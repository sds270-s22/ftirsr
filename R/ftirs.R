#' FTIRS class
#' A class attribute that is a modified dataframe that is in the proper format to be used in a Partial Least Squares Regression model
#' @name ftirs
NULL

#' A function that generates a tibble from a single FTIRS sample
#' @rdname ftirs
#' @param single_filepath The filepath to the your FTIR spectroscopy sample.
#' @param interpolate A logical value choosing to interpolate absorbance values onto a set of whole number wavenumbers. `TRUE` is default.
#' @param ... Other arguments passed on to methods. Not currently used.
#' @importFrom magrittr %>%
#' @import dplyr
#' @import readr
#' @importFrom fs path_file
#' @importFrom purrr map_dfr
#' @export


read_ftirs_file <- function(single_filepath, interpolate = TRUE, ...) {
  x <- read_csv(single_filepath, ...)
  x <- x %>%
    as_tibble()

  if (ncol(x) > 2) {
    x <- x %>%
      select(-1)
    warning("Deleted presumed index column.")
  }

  col_names <- names(x)
  if (FALSE %in% ifelse(col_names == c("wavenumber", "absorbance"), TRUE, FALSE)) {
    x <- x %>%
      rename(
        wavenumber = col_names[1],
        absorbance = col_names[2]
      )
    warning("Columns renamed to `wavenumber`, `absorbance`. Please make sure these
          labels match the contents of the columns.")
  }

  if(interpolate){
  x <- interpolate_ftirs(x$wavenumber, x$absorbance)
  }

  # Attach sample_id to each observation
  x <- x %>%
    mutate(sample_id = tools::file_path_sans_ext(fs::path_file(single_filepath)))

  return(x)

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

  x <- map_dfr(.x = files, .f = read_ftirs_file, interpolate = ...) %>%
        select(sample_id, everything())

  if (!is.null(wet_chem_path)) {
    x <- read_wet_chem(wet_chem_path, x)
  }

  class(x) <- c("ftirs", class(x))
  if (format == "wide") {
    x <- pivot_wider(x)
  }

  return(x)
}

#' Function that reads and attaches Wet Chemistry data to the FTIRS object
#' This function is called in `read_ftirs()` via the optional `wet_chem_path` argument.
#' @param filepath An optional filepath to singular Wet Chemistry Data file to be included in the FTIRS dataframe.
#' @param data The corresponding FTIRS dataframe to have the Wet Chemistry Data attached to.
#' @param ... Other arguments passed on to methods. Not currently used.
#' @importFrom readr read_csv
#' @importFrom magrittr %>%
#' @import dplyr
#' @export

read_wet_chem <- function(filepath, data) {
  wet_chem <- read_csv(filepath)

  sample_col_name <- names(wet_chem)[1]
  compound_col_name <- names(wet_chem)[2]
  data <- left_join(data, wet_chem, by = c("sample_id" = sample_col_name)) %>%
    rename(bsi = all_of(compound_col_name)) %>%
    # ideally, you can note if you're adding bsi or toc data or something else
    # but for now, users can change it if it's not bsi
    select(sample_id, bsi, everything())
  return(data)
}



#' Function that pivots the FTIRS dataframe to wider, non-tidy format, necessary for input into a PLSR model.
#' @rdname ftirs
#' @param ftirs_data_long A long, tidy format FTIRS dataframe.
#' @param ... Other arguments passed on to methods. Not currently used.
#' @importFrom magrittr %>%
#' @importFrom tidyr pivot_wider
#' @importFrom tibble column_to_rownames
#' @export

pivot_wider.ftirs <- function(ftirs_data_long, ...) {
  ftirs_data_wide <- as_tibble(ftirs_data_long) %>%
    pivot_wider(
      names_from = "wavenumber",
      values_from = "absorbance"
    ) %>%
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
#' @importFrom tibble rownames_to_column
#' @importFrom tidyr pivot_longer
#' @export

pivot_longer.ftirs <- function(ftirs_data_wide, wet_chem, ...) {
  ftirs_data_wide <- ftirs_data_wide %>%
    rownames_to_column(var = "sample_id") %>%
    as_tibble()

  upper_bound <- ncol(ftirs_data_wide)

  if (wet_chem == TRUE) {
    ftirs_data_long <- ftirs_data_wide %>%
      pivot_longer(3:all_of(upper_bound),
        names_to = "wavenumber",
        values_to = "absorbance"
      )
  } else {
    ftirs_data_long <- ftirs_data_wide %>%
      # these numbers look off, but it's because there's an additional col now
      pivot_longer(2:all_of(upper_bound),
        names_to = "wavenumber",
        values_to = "absorbance"
      )
  }
  class(ftirs_data_long) <- c("ftirs", class(ftirs_data_long))
  return(ftirs_data_long)
}

#' Function that checks if an object has the FTIRS class format
#' @param obj any R object
#' @param ... Other arguments passed on to methods. Not currently used.
#' @export
is.ftirs <- function(obj, ...) {
  "ftirs" %in% class(obj)
}

#' A function that predicts bsi content based on our model with your data
#' @rdname ftirs
#' @param your_data must be in the wide format -> looks like it might not have to be!
#' @param ... Other arguments passed on to methods. Not currently used.
#' @import pls
#' @importFrom tibble rownames_to_column
#' @importFrom stats predict
#' @export

predict.ftirs <- function(your_data, ...) {
  combined_artic_df_wide <- rbind(greenland, alaska) %>%
    pivot_wider()

  our_mod <- plsr(bsi ~ ., ncomp = 10, data = combined_artic_df_wide, validation = "CV", segments = 10)


  preds <- as.data.frame(predict(our_mod, data = your_data)) %>%
    rownames_to_column(var = "sample_id")
  ## these are the wrong sample_id names
  # eventually just return for component we want

  # predplot(our_mod, ncomp = 10, newdata =  your_data, asp = 1, line = TRUE)
}

