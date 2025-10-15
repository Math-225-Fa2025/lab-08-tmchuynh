# load packages ----------------------------------------------------------------

library(tidyverse)
library(rvest)

# set url ----------------------------------------------------------------------

#' URL for the first page of Edinburgh College of Art collection search results
#' Base URL targeting the first 10 items (offset=0) from the collection
first_url <- "https://collections.ed.ac.uk/art/search/*:*/Collection:%22edinburgh+college+of+art%7C%7C%7CEdinburgh+College+of+Art%22?offset=0"

