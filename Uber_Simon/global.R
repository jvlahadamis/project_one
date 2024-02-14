library(tidyverse)
library(rvest)
library(mongolite)
library(shiny)
library(DT)

connection_string <- "mongodb+srv://raolson:PasswordPassword@projectonedatabase.eyzpjva.mongodb.net/"
nbhTemp <- mongolite::mongo(collection = "neighbourhoods",
                        db = "project_one",
                        url = connection_string)
nbh <- as.data.frame(nbhTemp$find())

# Expression for calculating fare price, to mimic Uber's own pricing as the firm has not given API access
calculateUberPrice <- function(distance_km, time_of_day) {
  # Base fare
  base_fare <- 2.00

  # Cost per kilometer
  cost_per_km <- 0.75

  # Surge multiplier based on time of day
  surge_multiplier <- 1.0
  if (time_of_day >= 18 || time_of_day <= 6) {
    # Surge pricing in effect during evening and night hours
    surge_multiplier <- 1.5
  }

  # Calculate total fare
  total_fare <- base_fare + (cost_per_km * distance_km * surge_multiplier)

  return(total_fare)
}
