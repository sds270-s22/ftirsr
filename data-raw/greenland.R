## code to prepare `greenland` dataset goes here
library(tidyverse)
library(dplyr)
greenland <- read_csv("wetChemAbsorbance.csv")%>%
  select(-`...3`)
usethis::use_data(greenland, overwrite = TRUE)

