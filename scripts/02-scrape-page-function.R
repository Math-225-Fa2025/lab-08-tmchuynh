# load packages ----------------------------------------------------------------

library(tidyverse)
library(rvest)
library(tibble)
library(stringr)

# function: scrape_page --------------------------------------------------------

#' Scrape web page content for titles, links, and artists
scrape_page <- function(url) {
  # read page
  page <- read_html(url)

  # scrape titles
  titles <- page %>%
    html_nodes(".iteminfo") %>%
    html_node("h3 a") %>%
    html_text() %>%
    str_squish()

  # scrape links
  links <- page %>%
    html_nodes(".iteminfo") %>%
    html_node("h3 a") %>%
    html_attr("href") %>%
    str_replace("\\.", "https://collections.ed.ac.uk")

  # scrape artists
  artists <- page %>%
    html_nodes(".iteminfo") %>%
    html_node(".artist") %>%
    html_text()

  # create and return tibble
  tibble(
    title = titles,
    link = links,
    artist = artists
  )
}
