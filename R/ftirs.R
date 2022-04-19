#' A function that generates a dataframe in the proper format for the plsr model
#' note to specify how to format data
#' @param  The filepath to the your folder that contains the csv files for all your FTIR spectroscopy samples
#' @param  The filepath to the sample with wavenumbers you want to use
#' @importFrom magrittr %>%
#' @import dplyr
#' @import readr
#' @export

read_ftirs_file <- function(single_filepath, ...){
  x <- read_csv(single_filepath, ...)

  x <- x %>%
    as_tibble() %>%
    ## this next line might not be relevant if we specify not to have index col
    ## not sure what would be more standard
    select(-1)

  x <- interpolate_ftirs(x$wavenumber, x$absorbance) %>%
    mutate(sample_id = tools::file_path_sans_ext(fs::path_file(single_filepath)))

}

#' A function that generates a dataframe in the proper format for the plsr model
#' note to specify how to format data
#' @param  The filepath to the your folder that contains the csv files for all your FTIR spectroscopy samples
#' @param  The filepath to the sample with wavenumbers you want to use
#' @importFrom magrittr %>%
#' @import dplyr
#' @import readr
#' @export

read_ftirs <- function(dir_path, wet_chem_path, ...){
  files <- list.files(dir_path, full.names = TRUE)
  x <- files %>%
    map_dfr(read_ftirs_file)

  # need to universalize with "sample_id" and "Sample"
  # MAke wet chem optional!
  wet_chem <- read_csv(wet_chem_path)
  x <- left_join(x, wet_chem, by = c("sample_id" = "Sample"))

  class(x) <- c("ftirs", class(x))
  return(x)
}

