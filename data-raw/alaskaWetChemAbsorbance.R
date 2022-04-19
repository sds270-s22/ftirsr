## code to prepare `alaskaWetChemAbsorbance` dataset goes here
library(dplyr)
library(readr)
library(janitor)
library(magrittr)
library(tidyr)
alaskaWetChemAbsorbance <- read_csv("data-raw/AlaskaWetChemAbsorbance.csv")%>%
  clean_names() %>%
rename(bsi_percent = b_si_percent, sample_id = dataset)%>%
  pivot_longer(
  3:1884,
  names_to = "wavenumbers",
  values_to = "absorbance")
usethis::use_data(alaskaWetChemAbsorbance, overwrite = TRUE)
