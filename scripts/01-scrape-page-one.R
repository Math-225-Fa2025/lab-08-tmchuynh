# load packages ----------------------------------------------------------------

library(tidyverse)
library(rvest)

# set url ----------------------------------------------------------------------

#' URL for the first page of Edinburgh College of Art collection search results
#' Base URL targeting the first 10 items (offset=0) from the collection
first_url <- "https://collections.ed.ac.uk/art/search/*:*/Collection:%22edinburgh+college+of+art%7C%7C%7CEdinburgh+College+of+Art%22?offset=0"

# read first page --------------------------------------------------------------

#' Read and parse the HTML content from the first page
#' Downloads the webpage and creates an HTML document object for scraping
page <- read_html(first_url)

# scrape titles ----------------------------------------------------------------

#' Extract artwork titles from the webpage
#' Scrapes title text from h3 anchor elements within .iteminfo containers
#' Uses CSS selectors to target specific HTML elements and cleans whitespace
titles <- page %>%
  html_nodes(".iteminfo") %>%        # Select item information containers
  html_node("h3 a") %>%             # Select title links within h3 tags
  html_text() %>%                   # Extract text content
  str_squish()                      # Remove extra whitespace

# scrape links -----------------------------------------------------------------

#' Extract artwork detail page URLs
#' Scrapes href attributes and converts relative URLs to absolute URLs
#' Replaces relative path notation with full domain URL
links <- page %>%
  html_nodes(".iteminfo") %>%       # Select item information containers
  html_node("h3 a") %>%            # Select title links
  html_attr("href") %>%            # Extract href attribute values
  str_replace("\\.", "https://collections.ed.ac.uk")  # Convert to absolute URLs
