


p <- c("shiny", "tidyverse", "mongolite", "rvest", "geosphere", "DT", "lubridate", "bslib")
new.packages <- p[!(p %in% installed.packages()[, "Package"])]
if (length(new.packages)) {
  install.packages(new.packages, dependencies = TRUE)
}
