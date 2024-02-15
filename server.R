# Define Server Logic
server <- function(input, output) {
  
  # Initialize the connection to the MongoDB
  m <- mongolite::mongo(collection = "simulatedUsers",
                        db = "project_one",
                        url = connection_string)
  
  # Define reactive inputs for user input fields
  first <- reactive({ input$first })
  last <- reactive({ input$last })
  phone <- reactive({ input$phone })
  pickup <- reactive({ input$pickup })
  dropoff <- reactive({ input$dropoff })
  
  # Define reactive location variables for distance calculations in final pricing
  pickupLat <- reactive({nbh %>% 
                          dplyr::filter(Neighbourhood == input$pickup) %>% 
                          dplyr::select(Latitude)})
  pickupLong <- reactive({nbh %>% 
                           dplyr::filter(Neighbourhood == input$pickup) %>% 
                           dplyr::select(Longitude)})
  dropoffLat <- reactive({nbh %>% 
                           dplyr::filter(Neighbourhood == input$dropoff) %>% 
                           dplyr::select(Latitude)})
  dropoffLong <- reactive({nbh %>% 
                           dplyr::filter(Neighbourhood == input$dropoff) %>% 
                           dplyr::select(Longitude)})
   
  # Calculate distance based off user selection
  distance <- reactive({
    d1 <- geosphere::distm(c(as.numeric(pickupLong()), as.numeric(pickupLat())), 
                           c(as.numeric(dropoffLong()), as.numeric(dropoffLat())),
                           fun = distHaversine)
    # Convert from meters to kilometers and extract integer
    d1_km <- d1[1, 1] / 1000
  })
  
  # Define a reactive expression to count the number of rows in filtered data
  filtered_row_count <- reactive({
    nrow(filtered_data())
  })
  
  # Define final expression to calculate final cost of trip.
  final_individual_cost <- reactive({
    dplyr::case_when(round(calculateUberPrice(distance(),hour(Sys.time())) / filtered_row_count(), 2) <= 9999 ~ round(calculateUberPrice(distance(),hour(Sys.time())) / (filtered_row_count() + 1), 2),
                                TRUE ~ round(calculateUberPrice(distance(),hour(Sys.time())), 2))
  })

  # Define a reactive expression to filter the data based on user input
  filtered_data <- reactive({
    # Get the data from MongoDB
    data <- m$find()
    # Filter the data based on pickup and dropoff
    if (!is.null(pickup()) && pickup() != "") {
      data <- data[data$Pickup == pickup(), ]
    }
    if (!is.null(dropoff()) && dropoff() != "") {
      data <- data[data$Dropoff == dropoff(), ]
    }
    data
  })

  # Send data to MongoDB when the user clicks a button
  observeEvent(input$click, {
    m$insert(data.frame(First = first(),
                        Last = last(),
                        Pickup = pickup(),
                        Dropoff = dropoff(),
                        Phone = phone()))
  })
  
  # Render the filtered table
  output$table <- renderDataTable({
    filtered_data()
  }, options = list(
    language = list(
      emptyTable = "There are no active matches for your ride right now. You can request a solo ride now, or join the queue and wait for a match to contact you."
    ))
  )
  
  # Output the filtered row count
  output$cost <- renderText({
    paste0("Estimated cost of trip per rider: ", "$", final_individual_cost())
  })
}
