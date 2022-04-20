## code to prepare `greenland` dataset goes here
library(dplyr)
library(janitor)
library(tidyr)
library(readr)
library(magrittr)
greenland <- read_csv("data-raw/wetChemAbsorbance.csv")%>%
  select(-`...3`) %>%
  clean_names() %>%
  rename(bsi = b_si_percent, sample_id = dataset)%>%
  pivot_longer(
    3:3699,
    names_to = "wavenumber",
    values_to = "absorbance")
usethis::use_data(greenland, overwrite = TRUE)
