#' A function that predicts bsi content based on our model with your data
#' @param your_data must be in the wide format -> looks like it might not have to be!
#' @import pls
#' @export

# generic function
# but can't be rn bc the thing I'm putting in isn't actually an ftirs
#predict_ftirs


predict_ftirs <- function(your_data, ...){
  # do we want this to be a method? Bc we don't necessarily want to
  # predict with our model, or our full spec model


  # to predict your samples with our model
  # should call bsi or something more generic?
  #  need to find that BSi value for AK


  # 10 comp y/n?
  # these paths aren't going to work outside of the package, so need to
  # use the attached dfs
  # loading within the function is slow and sloppy
  # or, what if we save the mod as an .rda object
  # greenland_df <- read_ftirs("~/PLSmodel/Samples/greenland_csv",
  #                            "~/PLSmodel/csvFiles/wet-chem-data.csv"
  # )
  # alaska_df <- read_ftirs("~/PLSmodel/Samples/alaska_csv",
  #                         "~/PLSmodel/csvFiles/AlaskaWetChem.csv"
  # )   # this is missing one BSi value?
  #
  # combined_artic_df_wide <- rbind(greenland_df, alaska_df) %>%
  #   pivot_ftirs_wider()%>%
  #   select(-1883)
  #
  combined_artic_df_wide <- rbind(alaska, greenland) %>%
    pivot_ftirs_wider()

  our_mod <- plsr(bsi~., ncomp = 10, data = combined_artic_df_wide, validation = "CV", segments = 10)
  #summary(our_mod)
  # should summary be included?

  # is this how to access our object/most efficient?

  predict(our_mod, data = your_data)
  # predplot(our_mod, ncomp = 10, newdata =  your_data, asp = 1, line = TRUE)
  # should plot be included within this function or another thing?
  # probably something else because we can only return one thing and
  # don't really want to return a vector

}



## below is just trouble shooting nonesense
# # generating just greenland in case full spectrum of both combined is the issue
# greenland_wide <- greenland_df %>%
#   pivot_ftirs_wider()%>%
#   select(-1883)
#
# alaska_wide <- alaska_df %>%
#   pivot_ftirs_wider()%>%
#   select(-1883)
#
#
# greenland_mod <- plsr(bsi~., ncomp = 10, data = greenland_wide, validation = "CV", segments = 10)
#
# ak_mod <- plsr(bsi~., ncomp = 10, data = alaska_wide, validation = "CV", segments = 10)
#
# combined_mod <- plsr(bsi~., ncomp = 10, data = combined_artic_df_wide, validation = "CV", segments = 10)
#
# #these work
# predict(greenland_mod, greenland_wide %>%select(-1))
# predict(ak_mod, alaska_wide %>%select(-1))
# predict(ak_mod, your_data)
# predict(combined_mod, combined_artic_df_wide%>%select(-1))
#
# # these don't work
# predict(ak_mod, data = greenland_wide %>%select(-1))
# predict(greenland_mod, data =  your_data)
# predict(greenland_mod, data = combined_artic_df_wide%>%select(-1))
# predict(ak_mod, data = combined_artic_df_wide%>%select(-1))
# predict(greenland_mod, data = alaska_wide%>%select(-1))
#

# Hypothetical data our user has (it's just alaska)
# your_data <- read_ftirs("~/PLSmodel/Samples/alaska_csv") %>%
#   pivot_ftirs_wider() %>%
#   select(-1882)

# create_new_mod <- function(...){
#   # not sure if this is necessary/what it contributes besides just plsr()
# }







