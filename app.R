library(shiny)
library(tidyquant)
library(dplyr)
library(plotly)
library(TTR)  # For Bollinger Bands calculation

# Define UI
ui <- fluidPage(
    titlePanel("Stock Price Visualization with Bollinger Bands"),
    sidebarLayout(
        sidebarPanel(
            textInput(inputId = "first", 
                      label = "Enter first name",
                      value = "test"),
            
            textInput(inputId = "last", 
                      label = "Enter last name",
                      value = "test"),
            
            textInput(inputId = "pickup", 
                      label = "Enter pickup location",
                      value = "test"),
            
            textInput(inputId = "dropoff", 
                      label = "Enter dropoff location",
                      value = "test"),
            
        ),
        mainPanel(
            textOutput("output_text")
        )
    ),
    actionButton(inputId = "go", 
                 label = "test")
)

# Define Server Logic
server <- function(input, output) {
    
  connection_string = 'mongodb+srv://vlahadam:AlyS3ObBXgjba7OI@cluster0.ecrrnuo.mongodb.net/?retryWrites=true&w=majority'
  
  
  #this object will push to a collection and database. Collection creates a new collection within the db specified
  m <- mongolite::mongo(collection = "hhhhhhh",
                        db = "hhhhhhh",
                        url= connection_string)
  
  first <- reactive(input$first)
  last <- reactive(input$last)
  pickup <- reactive(input$pickup)
  dropoff <- reactive(input$dropoff)
  
  
  dataframe <- data.frame(first = first, 
                      last = last, 
                      pickup = pickup, 
                      dropoff = dropoff)
  
  
  
  output <- eventReactive(eventExpr = input$go,
                         valueExpr = {m$insert(dataframe)})
  output
}
  

# Run the App
shinyApp(ui = ui, server = server)
