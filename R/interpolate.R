#' A function to interpolate a dataset
#'
#' @param wavenumber The wavenumber vector
#' @param absorbance The absorbance vector
#' @param out_vec The wavenumber vector to be interpolated on
#' @import dplyr
#' @importFrom magrittr %>%
#' @importFrom readr read_csv
#' @importFrom stats approx na.omit

#' @export

interpolate_ftirs <- function(wavenumber, absorbance,
                              out_vec = rounded_wavenumbers$wavenumber) {

  # The meat of the function: returns both the interpolated absorbance vector and the wavenumber vec.
  tuple <- approx(as.numeric(wavenumber), as.numeric(absorbance), xout = out_vec)

  # Binds the two vectors back into a data frame
  df <- as.data.frame(tuple)

  # Giving the data frame useful names before passing it back
  df <- df %>%
    rename(wavenumber = x, absorbance = y)

  return(df)
}
