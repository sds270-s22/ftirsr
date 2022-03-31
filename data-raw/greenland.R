## code to prepare `greenland` dataset goes here
library(dplyr)
library(janitor)
greenland <- read_csv("data-raw/wetChemAbsorbance.csv")%>%
  select(-`...3`) %>%
  clean_names() %>%
  rename(bsi_percent = b_si_percent, sample_id = dataset)
usethis::use_data(greenland, overwrite = TRUE)

