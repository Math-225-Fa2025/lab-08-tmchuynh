# load packages ----------------------------------------------------------------

library(tidyverse)
library(rvest)
library(glue)

# source function --------------------------------------------------------------

source(
  "/home/tmchuynh/Documents/Data Science/lab-08-tmchuynh/scripts/02-scrape-page-function.R"
)

# list of urls to be scraped ---------------------------------------------------

#' Construct URLs for paginated search results
#'
#' Creates a sequence of URLs to scrape all pages of the Edinburgh College of Art
#' collection. The collection is paginated with 10 items per page, starting from
#' offset 0 and incrementing by 10 for each subsequent page.
root <- "https://collections.ed.ac.uk/art/search/*:*/Collection:%22edinburgh+college+of+art%7C%7C%7CEdinburgh+College+of+Art%22?offset="
numbers <- seq(from = 0, to = 2900, by = 10)
urls <- glue("{root}{numbers}")
