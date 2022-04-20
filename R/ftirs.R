#' A function that generates a tibble in the proper format for the plsr model
#' note to specify how to format data
#' @param single_filepath The filepath to the your FTIR spectroscopy sample.
#' @param ...
#' @importFrom magrittr %>%
#' @import dplyr
#' @import readr
#' @importFrom fs path_file
#' @importFrom purrr map_dfr
#' @export


read_ftirs_file <- function(single_filepath, ...) {
  x <- read_csv(single_filepath, ...)
  x <- x %>%
    as_tibble() %>%
    ## this next line might not be relevant if we specify not to have index col
    ## not sure what would be more standard
    select(-1)

  # use round()
  x <- interpolate_ftirs(x$wavenumber, x$absorbance) %>%
    mutate(sample_id = tools::file_path_sans_ext(fs::path_file(single_filepath)))
}

#' A function that generates a dataframe in the proper format for the plsr model
#' note to specify how to format data
#' @param dir_path filepath to the your folder that contains the csv files for all your FTIR spectroscopy samples
#' @param wet_chem_path Path to wet chemistry data the user wants to include in the ftirs dataframe. This is optional.
#' @param format The desired format of the ftirs dataframe, either long or wide. Long is easier to store and wide is necessary to input into the model.
#' @param ...
#' @importFrom magrittr %>%
#' @import dplyr
#' @importFrom purrr map_dfr
#' @import readr
#' @export

# is the format param too annoying? should default be long?
# or maybe have "wide = TRUE" arg instead?
read_ftirs <- function(dir_path, wet_chem_path = NULL, format = "long",  ...) {
  files <- list.files(dir_path, full.names = TRUE)
  x <- files %>%
    purrr::map_dfr(read_ftirs_file) %>%
    select(sample_id, everything()) %>%
    format(scientific = FALSE)

  if (!is.null(wet_chem_path)) {
    wet_chem <- read_csv(wet_chem_path)
    # need to universalize with "sample_id" and "Sample"
    # also BSi vs. bsi
    # don't really want to list `bsi` because could be adding toc!
    x <- left_join(x, wet_chem, by = c("sample_id" = "Sample")) %>%
      rename(bsi = Bsi) %>%
      select(sample_id, bsi, everything())
  }

#  class(x) <- c("ftirs", class(x))
  # don't need this if we are calling long/wide
  # is there a neater/less clunky way to do this?

  if(format == "wide"){
    x <- pivot_ftirs_wider(x)
  }

  return(x)
}

#' Function that pivots the ftirs df to wider format that is necessary for the PLS model
#' @param ftirs_data_long A long ftirs dataframe that contains columns for wavenumber and absorbance.
#' @param ...
#' @importFrom magrittr %>%
#' @importFrom tidyr pivot_wider
#' @importFrom tibble column_to_rownames
#' @export

pivot_ftirs_wider <- function(ftirs_data_long, ...) {
  ftirs_data_wide <- ftirs_data_long %>%
    pivot_wider(
      names_from = "wavenumber",
      values_from = "absorbance"
    )  %>%
    ## Not positive this is necessary to make `sample_id` a rowname
    column_to_rownames(var = "sample_id")

  class(ftirs_data_wide) <- c("ftirs", class(ftirs_data_wide))
  return(ftirs_data_wide)
}

#' Function that pivots a wide ftirs dataframe back to a long format that is easier to store.
#' @param ftirs_data_wide A wide ftirs dataframe that has a column for each wavenumber and a row for each sample.
#' @param wet_chem A logical value that states if there is a column including wet chemistry data in the wide ftirs dataframe the user is inputting. `TRUE` means there is such column, `FALSE` denotes there is not.
#' @param ...
#' @importFrom magrittr %>%
#' @importFrom tidyr pivot_longer
#' @export

pivot_ftirs_longer <- function(ftirs_data_wide, wet_chem, ...) {
    ftirs_data_wide <- ftirs_data_wide %>%
      rownames_to_column(var = "sample_id")

    if(wet_chem == TRUE){
      ftirs_data_long <- ftirs_data_wide %>%
      pivot_longer(3:1884,
      names_to = "wavenumber",
      values_to = "absorbance"
    )
    }else{
      ftirs_data_long <- ftirs_data_wide %>%
        pivot_longer(2:1883,
        names_to = "wavenumber",
        values_to = "absorbance"
        )}
  class(ftirs_data_long) <- c("ftirs", class(ftirs_data_long))
  return(ftirs_data_long)
}
