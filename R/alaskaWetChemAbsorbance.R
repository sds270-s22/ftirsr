## code to prepare `alaskaWetChemAbsorbance` dataset goes here
library(dplyr)
library(readr)
library(janitor)
alaskaWetChemAbsorbance <- read_csv("data-raw/AlaskaWetChemAbsorbance.csv")%>%
  clean_names()%>%
  rename(bsi_percent = b_si_percent, sample_id = dataset)
usethis::use_data(alaskaWetChemAbsorbance, overwrite = TRUE)
