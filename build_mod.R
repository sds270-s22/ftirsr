## use greenland and alaska or use functions to gen
## i think greenland and alaska maybeeee if we fix the csv
## this file delete beofre compile packge

library(pls)
library(stats)

greenland_df <- read_ftirs("~/PLSmodel/Samples/greenland_csv",
                           "~/PLSmodel/csvFiles/wet-chem-data.csv"
)
alaska_df <- read_ftirs("~/PLSmodel/Samples/alaska_csv",
                        "~/PLSmodel/csvFiles/AlaskaWetChem.csv"
)  # this is missing one BSi value?

combined_artic_df_wide <- rbind(greenland_df, alaska_df) %>%
  pivot_ftirs_wider()%>%
  select(-1883)

# generating just greenland in case full spectrum of both combined is the issue
greenland_wide <- greenland_df %>%
  pivot_ftirs_wider() %>%
  select(-1883)

greenland_mod <- plsr(bsi~., ncomp = 10, data = greenland_wide, validation = "CV", segments = 10)
summary(greenland_mod)

predict(greenland_mod, greenland_wide %>%select(-1))
predict(greenland_mod, your_data)
# Hypothetical data our user has (it's just alaska)
your_data <- read_ftirs("~/PLSmodel/Samples/alaska_csv") %>%
  pivot_ftirs_wider() %>%
  select(-1882)

create_new_mod <- function(...){
  # not sure if this is necessary/what it contributes besides just plsr()
}

#' @param your_data must be in the wide format

# to predict your samples with our model
# should call bsi or something more generic?
predict_bsi <- function(your_data, ...){
  # I'm confused about what is being predicted, whether predicting with our
  # data or your data
  # 10 comp y/n?
  our_mod <- plsr(bsi~., ncomp = 10, data = combined_artic_df_wide, validation = "CV", segments = 10)
  #summary(our_mod)
  # should summary be included?
  predict(our_mod, your_data)
 # predplot(our_mod, ncomp = 10, newdata =  your_data, asp = 1, line = TRUE)
  # should plot be included within this function or another thing?
  # probably something else because we can only return one thing and
  # don't really want to return a vector

}






