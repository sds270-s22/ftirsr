## code to prepare `greenland` dataset goes here
library(dplyr)
library(readr)
library(magrittr)
greenland <- read_csv("data-raw/greenland.csv") %>%
  select(-1)
class(greenland) <- c("ftirs", class(greenland))
usethis::use_data(greenland, overwrite = TRUE)
