## code to prepare `greenland` dataset goes here
library(tidyverse)
library(dplyr)
greenland <- read_csv("data-raw/wetChemAbsorbance.csv")%>%
  select(-`...3`) %>%
  janitor::clean_names() %>%
  rename(bsi_percent = b_si_percent, sample_id = dataset)
usethis::use_data(greenland, overwrite = TRUE)

