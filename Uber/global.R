library(tidyverse)
library(rvest)
library(mongolite)

connection_string <- "mongodb+srv://raolson:PasswordPassword@projectonedatabase.eyzpjva.mongodb.net/"
nbhTemp <- mongolite::mongo(collection = "neighbourhoods",
                        db = "project_one",
                        url = connection_string)
nbh <- as.data.frame(nbhTemp$find())
