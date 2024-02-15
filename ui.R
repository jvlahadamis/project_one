


ui <- shiny::shinyUI(fluidPage(
  theme = bslib::bs_theme(bg = "#101010", 
                          fg = "#FFF", 
                          primary = "#48DAC6", 
                          secondary = "#48DAC6", 
                          base_font = font_google("Open Sans"), 
                          "progress-bar-bg" = "orange"),
  
  
  titlePanel("Uber Ridesharing"),
  HTML("<p style='font-size: 16px;'>Need a ride, but don't want to pay full price? This app is designed to help you find people in the Edmonton Region who want to take a similar Uber trip as you so you can split the cost! By joining the queue, you consent to receive communications at the phone number entered for the purposes of booking an Uber ride with other users.</p>"),
  sidebarLayout(
    sidebarPanel(
      textInput(inputId = "first", 
                label = "Enter First Name",
                value = ""),
      
      textInput(inputId = "last", 
                label = "Enter Last Name",
                value = ""),
      
      textInput(inputId = "phone",
                label = "Enter Phone Number",
                value = ""),
      
      selectInput(inputId = "pickup", 
                  label = "Select Pickup Location", 
                  choices = nbhOnly),
      
      selectInput(inputId = "dropoff",
                  label = "Select Dropoff Location",
                  choices = nbhOnly),
      
      actionButton(inputId = "click", 
                   label = "Join Queue")),
    
    mainPanel(
      dataTableOutput("table"),
      textOutput("cost"),
      tags$div(
        style = "margin-top: 20px;",
        column(12, 
             align = "center", 
             tags$p(class = "footer-text", "All trip pricing quotes are estimates only. Pricing is based on the assumption that the cost is split between yourself and all active users in the queue for your trip. To book your ride, please contact the other riders in your area to coordinate the trip booking. The name 'Uber' and the Uber app are owned entirely by Uber Technolgies Inc. and are not associated with this project."),
             tags$style(HTML(".footer-text { font-size: 9px; }")))
      )
  )
)))