#' A function that generates a dataframe in the proper format for the plsr model
#'
#' @param your_csv_folder The filepath to the your folder that contains the csv files for all your FTIR spectroscopy samples
#' @param your_wavenumbers The filepath to the sample with wavenumbers you want to use
#' @importFrom magrittr %>%

library(tidyverse)

generate_alaska <- function(your_csv_folder, your_wavenumbers){
  # First need to load list of sample names
  # Create a list of all the file names in the folder
  fname <- list.files(your_csv_folder, full.names = T)

  # Read all samples into a list
  filelist <- purrr::map(fname, read_csv)

  # Add names to samples
  names(filelist) <- gsub(".*/(.*)\\..*", "\\1", fname)

  # select the columns we want
  filelist <- purrr::map(filelist, function(x) {
    x %>%
      select(wavenumber, absorbance)
  })

  # Make the columns names the wavenumbers and the values the absorbance values
  reformattedData <- lapply(filelist, function(x) {
    pivot_wider(x, names_from = wavenumber, values_from = absorbance)

  })

  # create a matrix of the wavenumbers from each sample
  wavenumber_matrix <- map(reformattedData, names)

  # Convert matrix into data frame where each sample is its own row of wavenumber values
  wavenumber_df <- as.data.frame(do.call("rbind", wavenumber_matrix))
  # After this Vivienne didn't "trust" it to store the names so she added them as a column..
  # Something we should worry about? It's because detaching to create absorbance matrix...


  dropNames <- function(data) {
    names(data) <- paste("V", 1:ncol(data), sep = "")
    return(data)
  }

  # creating new list of df where there aren't any wavenumbers...only absorbance values [1:3697]
  absorbance_matrix <- map(reformattedData, dropNames)
  absorbance_df <- as.data.frame(do.call("rbind", absorbance_matrix))

  # Read in
  # do we want the ak_wav to be the generic?
  # or could a call to interpolate be a good idea?
  wavenumbers <- read_csv(your_wavenumbers) %>%
    select(wavenumber)


  colnames(absorbance_df) <- wavenumbers

# # Adding the wet chem sample
#   your_wet_chem <- read_csv("Maxwell-Alaska Samples  - Final Top 100.csv") %>%
#     janitor::clean_names() %>%
#     select(-notes, -toc_percent)
#
#   names(alaska_wet_chem)[2] <- "BSi"
#
#   absorbance_df <- absorbance_df %>%
#     rownames_to_column(var = "sample")
#
#   # Alaska dataframe ready for model
#   your_df <- full_join(absorbance_df, your_wet_chem, by = "sample") %>%
#     select(BSi, everything()) %>%
#     column_to_rownames(var = "sample")%>%
#     # Deleted last column because  0 values
#     select(-1883)
#
#   alaska_df[81,1] <- 23

 # return(your_df)
  return(absorbance_df)
}
