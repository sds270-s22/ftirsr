#' Interpolates a dataset to have uniform wavenumbers
#' @export

# Wavenumber: the wavenumber vector alone
# Absorbance: the absorbance vector alone
# Out_vec: the wavenumber vector to be interpolated onto - in this case using the Alaska Wavenumbers

interpolate <- function(wavenumber, absorbance, out_vec) {

  # The meat of the function: returns both the interpolated absorbance vector and the wavenumber vec.
  tuple <- approx(as.numeric(wavenumber), as.numeric(absorbance), xout = out_vec)

  # Binds the two vectors back into a data frame
  df <- as.data.frame(tuple)

  # Giving the data frame useful names before passing it back
  df <- df %>%
    rename(wavenumber = x, absorbance = y)
}

