


# Define Server Logic
server <- function(input, output) {
  
  
  #this object will push to a collection and database. Collection creates a new collection within the db specified
  m <- mongolite::mongo(collection = "project_one",
                        db = "project_one",
                        url= 'mongodb+srv://raolson:PasswordPassword@projectonedatabase.eyzpjva.mongodb.net')
  
  
  
  #create reactives for dataframe
  first <- reactive({input$first})
  last <- reactive({input$last})
  pickup <- reactive({input$pickup})
  dropoff <- reactive({input$dropoff})
  
  
  #create dataframe. this also needs to be inside of a reactive since it is 
  #consuming reactive objects
  dayta <- reactive({data.frame(first = first(), 
                                last = last(), 
                                pickup = pickup(), 
                                dropoff = dropoff())})
  
  
  #send data to mongodb
  take_the_click <- observeEvent(input$click, {
    m$insert(dayta())
  })
  
  
  
  #pull in the whole table including the new record that was just added by the 
  #user
  output$table <- renderDataTable(m$find())
  
  output
}