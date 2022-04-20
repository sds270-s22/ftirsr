## code to prepare `rounded_wavenumbers` vector (wavenumbers to interpolate onto, `out_vec` in function) for interpolation goes here
library(dplyr)
library(janitor)
library(tidyr)
library(readr)
library(magrittr)

wavenumbers <- read_csv("data-raw/AS-01\ (8_24_16).0.csv")
## This "rounds" the absorbance column to zero, but this column is just a filler
## in order to include as a dataset
rounded_wavenumbers <- round(wavenumbers, digits = 0) %>%
  select(-1) %>%
  rename(dummy_absorbance = absorbance)
usethis::use_data(rounded_wavenumbers, internal = TRUE, overwrite = TRUE)
