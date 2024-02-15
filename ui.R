ui <- fluidPage(
  titlePanel("Uber Pool"),
  sidebarLayout(
    sidebarPanel(
      textInput(inputId = "first", 
                label = "Enter first name",
                value = ""),
      
      textInput(inputId = "last", 
                label = "Enter last name",
                value = ""),
      
      selectInput(inputId = "pickup", 
                  label = "Select pickup location", 
                  choices = nbhOnly),
      
      selectInput(inputId = "dropoff",
                  label = "Select dropoff location",
                  choices = nbhOnly),
      
      actionButton(inputId = "click", 
                   label = "send to mongo")),
    
    mainPanel(
      dataTableOutput("table"),
      textOutput("filtered_row_count"),
      textOutput("distance"))
  ),
  
)


