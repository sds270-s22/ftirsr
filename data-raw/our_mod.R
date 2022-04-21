## code to prepare `our_mod as an rda
## not sure If this is really what we should do
## and think this is TEMPORARY just to see if this works!
## not sure if need to doc bc internal
## need to specify internal?
library(pls)
library(magrittr)
library(plsr)
library(dplyr)

greenland_df <- read_ftirs("~/PLSmodel/Samples/greenland_csv",
                           "~/PLSmodel/csvFiles/wet-chem-data.csv"
)
alaska_df <- read_ftirs("~/PLSmodel/Samples/alaska_csv",
                        "~/PLSmodel/csvFiles/AlaskaWetChem.csv"
)   # this is missing one BSi value?

combined_artic_df_wide <- rbind(greenland_df, alaska_df) %>%
  pivot_ftirs_wider()%>%
  select(-1883)

our_mod <- plsr(bsi~., ncomp = 10, data = combined_artic_df_wide, validation = "CV", segments = 10)
save(our_mod, file = "our_mod.rda")
