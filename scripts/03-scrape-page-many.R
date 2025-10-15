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

# map over all urls and output a data frame ------------------------------------

#' Scrape data from all URLs and combine into single data frame
#'
#' Uses map_dfr() to apply the scrape_page() function to each URL in the urls vector.
#' The function automatically combines all individual page results into one
#' comprehensive data frame with consistent column structure.
#'
#' returnsuoe_art Complete data frame containing all scraped art collection records
uoe_art <- map_dfr(urls, scrape_page)

# write out data frame ---------------------------------------------------------

#' Export scraped data to CSV file
#'
#' Saves the complete University of Edinburgh art collection dataset to a CSV file
#' for further analysis and processing. The file is stored in the data directory
#' with UTF-8 encoding to preserve special characters in artwork titles and descriptions.
write_csv(uoe_art, file = "lab-08-tmchuynh/data/uoe-art.csv")
