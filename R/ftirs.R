#' FTIRS class
#' @name ftirs
NULL

#' A function that generates a tibble from a single FTIRS sample
#' @rdname ftirs
#' @param single_filepath The filepath to the your FTIR spectroscopy sample.
#' @param ... Other arguments passed on to methods. Not currently used.
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

#' A function that generates a tidy data frame binding multiple FTIRS samples together
#' @rdname ftirs
#' @param dir_path Filepath to the folder that contains the csv files with FTIRS samples. Each file should be formatted such that there are three columns; index, `wavenumber` (numeric), and `absorbance` (numeric).
#' @param wet_chem_path An optional filepath to singular Wet Chemistry Data file to be included in the FTIRS dataframe.
#' @param format The desired format of the FTIRS dataframe; `long` (default) or `wide`.
#' @param ... Other arguments passed on to methods. Not currently used.
#' @importFrom magrittr %>%
#' @import dplyr
#' @importFrom purrr map_dfr
#' @import readr
#' @export

read_ftirs <- function(dir_path, wet_chem_path = NULL, format = "long", ...) {
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

  if (format == "wide") {
    x <- pivot_ftirs_wider(x)
  }

  return(x)
}

#' Function that pivots the FTIRS dataframe to wider, non-tidy format, necessary for input into a PLSR model.
#' @rdname ftirs
#' @param ftirs_data_long A long, tidy format FTIRS dataframe.
#' @param ... Other arguments passed on to methods. Not currently used.
#' @importFrom magrittr %>%
#' @importFrom tidyr pivot_wider
#' @importFrom tibble column_to_rownames
#' @export

pivot_ftirs_wider <- function(ftirs_data_long, ...) {
  ftirs_data_wide <- ftirs_data_long %>%
    pivot_wider(
      names_from = "wavenumber",
      values_from = "absorbance"
    ) %>%
    ## Not positive this is necessary to make `sample_id` a rowname
    column_to_rownames(var = "sample_id")

  class(ftirs_data_wide) <- c("ftirs", class(ftirs_data_wide))
  return(ftirs_data_wide)
}

#' Function that pivots a wide, non-tidy FTIRS dataframe to a long, tidy format.
#' @rdname ftirs
#' @param ftirs_data_wide A wide, non-tidy FTIRS dataframe. Columns = wavenumber, rows = sample_id, and values = absorbance.
#' @param wet_chem A logical value (`TRUE` or `FALSE`) indicating presence of Wet Chemistry Data in the wide FTIRS dataframe.
#' @param ... Other arguments passed on to methods. Not currently used.
#' @importFrom magrittr %>%
#' @importFrom tidyr pivot_longer
#' @export

pivot_ftirs_longer <- function(ftirs_data_wide, wet_chem, ...) {
  ftirs_data_wide <- ftirs_data_wide %>%
    rownames_to_column(var = "sample_id")

  if (wet_chem == TRUE) {
    ftirs_data_long <- ftirs_data_wide %>%
      pivot_longer(3:1884,
        names_to = "wavenumber",
        values_to = "absorbance"
      )
  } else {
    ftirs_data_long <- ftirs_data_wide %>%
      pivot_longer(2:1883,
        names_to = "wavenumber",
        values_to = "absorbance"
      )
  }
  class(ftirs_data_long) <- c("ftirs", class(ftirs_data_long))
  return(ftirs_data_long)
}
