## code to prepare `alaska` dataset goes here
library(dplyr)
library(readr)
library(magrittr)
alaska <- read_csv("data-raw/alaska.csv")%>%
  select(-1)
class(alaska) <- c("ftirs", class(alaska))
usethis::use_data(alaska, overwrite = TRUE)
