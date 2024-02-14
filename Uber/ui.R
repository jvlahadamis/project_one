library(shiny)
library(tidyverse)

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
                  choices = neighborhoods[1]),
      
      selectInput(inputId = "dropoff",
                  label = "Select dropoff location",
                  choices = neighborhoods[1]),
      
      actionButton(inputId = "click", 
                   label = "send to mongo")),
      
    mainPanel(
      dataTableOutput("table"))
    ),
 
)