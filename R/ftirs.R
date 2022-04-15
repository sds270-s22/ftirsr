#' A function that generates a dataframe in the proper format for the plsr model
#' note to specify how to format data
#' @param your_csv_folder The filepath to the your folder that contains the csv files for all your FTIR spectroscopy samples
#' @param wavenumbers The filepath to the sample with wavenumbers you want to use
#' @importFrom magrittr %>%
#' @import dplyr

read_ftirs_file <- function(single_filepath, ...){
  x <- read_csv(single_filepath, ...)

  # not sure if this next part doesn't go here
  # we can ask Ben in Office hours
  # If we are using this format, must make sure we are
  # somehow interpolating the proper wavenumbers, or using placeholders
  x <- x %>%
    as_tibble() %>%
    ## this next line might not be relevant if we specify not to have index col
    ## not sure what would be more standard
    select(-1)

  # add outvec because only knows now because we loaded it
  x <- interpolate_ftirs(x$wavenumber, x$absorbance, out_vec) %>%
    mutate(sample_id = tools::file_path_sans_ext(fs::path_file(single_filepath)))
}

# input the folder ?????
read_ftirs <- function(dir_path, ...){
  files <- list.files(dir_path, full.names = TRUE)

  x <- files %>%
    # the problem is that read_ftirs_file is expecting a filepath, and files
    # is the name of the files
    map_dfr(read_ftirs_file)
    class(x) <- c("ftirs", class(x))
  return(x)
}
