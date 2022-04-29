
<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- badges: start -->

[![R-CMD-check](https://github.com/sds270-s22/ftirsr/workflows/R-CMD-check/badge.svg)](https://github.com/sds270-s22/ftirsr/actions)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![CRAN
status](https://www.r-pkg.org/badges/version/ftirsr)](https://CRAN.R-project.org/package=ftirsr)
<!-- badges: end -->

# ftirsr <img src="./data-raw/Sticker/ftiRRRs.png" align="right" height=140/>

The goal of `ftirsr` is to help easily create a Partial Least Squares
Regression model to estimate composition of natural compounds such as
biogenic silica and total organic carbon in lake sediment core samples.

## Installation

The development version from GitHub can be accessed like so:

``` r
remotes::install_github("sds270-s22/ftirsr")
#> Skipping install of 'ftirsr' from a github remote, the SHA1 (9eee09d7) has not changed since last install.
#>   Use `force = TRUE` to force installation
```

## Examples

``` r
library(ftirsr)
library(tidyverse)
library(pls)

# This shows finding the maximum biogenic silica percentage in the dataset
max(greenland$bsi)
#> [1] 30.61
```

``` r
# This shows how to easily read a directory of FTIRS samples into R while attaching Wet Chemistry values and interpolating onto a vector of rounded wavenumbers for ease of interpretation

my_data <- read_ftirs(dir_path = "~/ftirsr/tests/testthat/test_samples",
                      wet_chem_path = "~/ftirsr/tests/testthat/wet-chem-data.csv")

head(my_data)
#>   sample_id   bsi wavenumber   absorbance
#> 1 FISK-10.0 20.37       3996 0.0007000000
#> 2 FISK-10.0 20.37       3994 0.0007020861
#> 3 FISK-10.0 20.37       3992 0.0006977220
#> 4 FISK-10.0 20.37       3991 0.0006717982
#> 5 FISK-10.0 20.37       3989 0.0006199506
#> 6 FISK-10.0 20.37       3987 0.0005513442
```

``` r
 # This shows pivoting the ftirs dataframe to the wide format necessary to run in a PLS model
my_data_wide <- my_data %>%
  pivot_wider()

# Showing the first 5 columns and the first 10 rows
head(my_data_wide[1:5], 10)
#>              bsi          3996          3994          3992          3991
#> FISK-10.0  20.37  0.0007000000  0.0007020861  0.0006977220  0.0006717982
#> FISK-110.0 11.82 -0.0235148501 -0.0235046029 -0.0235894673 -0.0236516844
#> FISK-270.0 11.29  0.0005814169  0.0005024497  0.0003133435  0.0002148331
```

``` r
# It is just as easy to pivot back
# Wet Chem data is included, so we denote that with wet_chem = TRUE
my_data_long <- my_data_wide %>%
  pivot_longer(wet_chem = TRUE)

head(my_data_long)
#> # A tibble: 6 × 4
#>   sample_id   bsi wavenumber absorbance
#>   <chr>     <dbl>      <dbl>      <dbl>
#> 1 FISK-10.0  20.4       3996   0.0007  
#> 2 FISK-10.0  20.4       3994   0.000702
#> 3 FISK-10.0  20.4       3992   0.000698
#> 4 FISK-10.0  20.4       3991   0.000672
#> 5 FISK-10.0  20.4       3989   0.000620
#> 6 FISK-10.0  20.4       3987   0.000551
```

``` r
# We can confirm that this object is class `ftirs`, which is necessary to access methods, such as predict.ftirs()
is.ftirs(my_data_wide)
#> [1] TRUE
```

``` r
# It is easy to predict the amount of Biogenic Silica in your sample using our model that is trained on 131 arctic lake sediment core samples
preds <- predict(my_data_wide)
preds
#>    sample_id bsi.1 comps bsi.2 comps bsi.3 comps bsi.4 comps bsi.5 comps
#> 1  FISK-10.0    16.30280    21.28228    19.35775    17.77782    16.72570
#> 2 FISK-110.0    11.68072    17.06655    15.25301    13.85117    10.46511
#> 3 FISK-270.0    14.58335    18.84250    16.80977    15.77409    14.98739
#>   bsi.6 comps bsi.7 comps bsi.8 comps bsi.9 comps bsi.10 comps
#> 1    15.19624    14.93517    14.24146    14.96709     15.79963
#> 2    10.43918    12.88861    12.31531    13.33525     14.32237
#> 3    14.02127    13.71863    13.30506    14.06645     15.13158
```

For more usage, please see our
[vignette](https://github.com/sds270-s22/ftirsr/blob/main/vignettes/Vignette.Rmd)
