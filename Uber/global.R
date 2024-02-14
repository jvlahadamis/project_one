library(tidyverse)
library(rvest)
sn <- rvest::read_html("https://en.wikipedia.org/wiki/List_of_neighbourhoods_in_Edmonton#List") %>% 
  rvest::html_nodes("table.wikitable") %>% 
  rvest::html_table(fill = TRUE)
neighborhoods <- sn[[1]] %>% as.data.frame()
  #as.numeric(.$`Population(2012)[56]`)
#dplyr::select(1, 8)
#as.numeric(unnest(neighborhoods, cols = `Population(2012)[56]`))







