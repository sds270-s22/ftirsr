#' A function that generates a dataframe in the proper format for the plsr model
#' note to specify how to format data
#' @param your_csv_folder The filepath to the your folder that contains the csv files for all your FTIR spectroscopy samples
#' @param wavenumbers The filepath to the sample with wavenumbers you want to use
#' @importFrom magrittr %>%
#' @import dplyr

read_ftirs_file <- function(single_filepath, ...){
  x <- read_csv(single_filepath, ...)
  # Add names to samples
  names(x) <- gsub(".*/(.*)\\..*", "\\1", single_filepath)
}

# input the folder ?????
read_ftirs <- function(filepath, ...){
  files <- list.files(filepath)

  x <- files %>%
    # the problem is that read_ftirs_file is expecting a filepath, and files
    # is the name of the files
    map_df(read_ftirs_file, files)
  class(x) <- c("ftirs", class(x))
  return(x)
}
