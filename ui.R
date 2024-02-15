ui <- fluidPage(
  titlePanel("Uber Pool"),
  sidebarLayout(
    sidebarPanel(
      textInput(inputId = "first", 
                label = "Enter First Name",
                value = ""),
      
      textInput(inputId = "last", 
                label = "Enter Last Name",
                value = ""),
      
      selectInput(inputId = "pickup", 
                  label = "Select Pickup Location", 
                  choices = nbhOnly),
      
      selectInput(inputId = "dropoff",
                  label = "Select Dropoff Location",
                  choices = nbhOnly),
      
      actionButton(inputId = "click", 
                   label = "Request Rideshare")),
    
    mainPanel(
      dataTableOutput("table"),
      textOutput("cost")
  ),
))