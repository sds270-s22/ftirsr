#' A function to interpolate a dataset
#'
#' @param wavenumber The wavenumber vector
#' @param absorbance The absorbance vector
#' @param out_vec The wavenumber vector to be interpolated on
#' @param ... Other arguments passed on to methods. Not currently used.
#' @import dplyr
#' @importFrom magrittr %>%
#' @importFrom readr read_csv
#' @importFrom stats approx na.omit

#' @export

interpolate_ftirs <- function(wavenumber, absorbance,
                              out_vec = rounded_wavenumbers$wavenumber, ...) {
  if(length(wavenumber)>3762){
    warning("Samples provided have significantly larger wavenumber spectrum than wavenumbers interpolated on to. Consider not interpolating (interpolate = FALSE) samples to preserve entire spectrum.")
  }
  if(length(wavenumber)<1881){
    warning("Returned NA absorbance values.")
  }

  # The meat of the function: returns both the interpolated absorbance vector and the wavenumber vec.
  tuple <- approx(as.numeric(wavenumber), as.numeric(absorbance), xout = out_vec)

  # Binds the two vectors back into a data frame
  df <- as.data.frame(tuple)

  # Giving the data frame useful names before passing it back
  df <- df %>%
     rename(wavenumber = x, absorbance = y) #%>%
    # format(scientific = FALSE)

  return(df)
}
