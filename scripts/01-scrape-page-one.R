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

# scrape artists ---------------------------------------------------------------

#' Extract artist names for each artwork
#' Scrapes artist information from elements with .artist class
artists <- page %>%
  html_nodes(".iteminfo") %>%       # Select item information containers
  html_node(".artist") %>%          # Select artist information elements
  html_text()                      # Extract artist names

# put together in a data frame -------------------------------------------------

#' Create a structured data frame with first ten artworks
#' Combines scraped data into a tibble with title, artist, and link columns
#' returns tibble with 10 rows containing artwork information
first_ten <- tibble(
  title = titles,    # Artwork titles
  artist = artists,  # Artist names
  link = links      # URLs to detailed artwork pages
)

# scrape second ten paintings --------------------------------------------------

#' URL for the second page of search results (items 11-20)
#' Similar to first_url but with offset=10 to get next 10 items
second_url <- "https://collections.ed.ac.uk/art/search/*:*/Collection:%22edinburgh+college+of+art%7C%7C%7CEdinburgh+College+of+Art%22?offset=10"

#' Read and parse HTML content from the second page
page <- read_html(second_url)

#' Extract titles from second page using same methodology as first page
titles <- page %>%
  html_nodes(".iteminfo") %>%
  html_node("h3 a") %>%
  html_text() %>%
  str_squish()

#' Extract links from second page and convert to absolute URLs
links <- page %>%
  html_nodes(".iteminfo") %>%
  html_node("h3 a") %>%
  html_attr("href") %>%
  str_replace("\\.", "https://collections.ed.ac.uk")
