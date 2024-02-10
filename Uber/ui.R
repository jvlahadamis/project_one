#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define UI for application that draws a histogram
fluidPage(

    # Application title
    titlePanel("Uber App"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput("nbhs1", "Select Start", choices = neighborhoods, multiple = F, selected = neighborhoods[1]),
            selectInput("nbhs2", "Select Destination", choices = neighborhoods, multiple = F, selected = neighborhoods[1])),

        mainPanel(
          
        )
    )
)