## code to prepare `alaska` dataset goes here
library(dplyr)
library(readr)
library(magrittr)
alaska <- read_csv("data-raw/alaska.csv")%>%
  select(-1)
usethis::use_data(alaska, overwrite = TRUE)
