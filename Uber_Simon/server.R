# Define Server Logic
server <- function(input, output) {
  
  # Initialize the connection to the MongoDB
  m <- mongolite::mongo(collection = "project_one",
                        db = "project_one",
                        url = 'mongodb+srv://raolson:PasswordPassword@projectonedatabase.eyzpjva.mongodb.net')
  
  # Define reactive inputs for user input fields
  first <- reactive({ input$first })
  last <- reactive({ input$last })
  pickup <- reactive({ input$pickup })
  dropoff <- reactive({ input$dropoff })
  
  # Define a reactive expression to filter the data based on user input
  filtered_data <- reactive({
    # Get the data from MongoDB
    data <- m$find()
    # Filter the data based on pickup and dropoff
    if (!is.null(pickup()) && pickup() != "") {
      data <- data[data$pickup == pickup(), ]
    }
    if (!is.null(dropoff()) && dropoff() != "") {
      data <- data[data$dropoff == dropoff(), ]
    }
    data
  })
  
  # Define a reactive expression to count the number of rows in filtered data
  filtered_row_count <- reactive({
    nrow(filtered_data())
  })
  
  # Send data to MongoDB when the user clicks a button
  observeEvent(input$click, {
    m$insert(data.frame(first = first(),
                        last = last(),
                        pickup = pickup(),
                        dropoff = dropoff()))
  })
  
  # Render the filtered table
  output$table <- renderDataTable({
    filtered_data()
  })
  
  # Output the filtered row count
  output$filtered_row_count <- renderText({
    paste("Number of rows after filtering:", filtered_row_count())
  })
}
