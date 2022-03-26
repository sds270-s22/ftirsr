## code to prepare `greenland` dataset goes here
library(tidyverse)
greenland <- read_csv("wetChemAbsorbance.csv")
usethis::use_data(greenland, overwrite = TRUE)
