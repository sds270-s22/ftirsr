
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
#> Downloading GitHub repo sds270-s22/ftirsr@HEAD
#> 
#>      checking for file ‘/private/var/folders/5m/f1fw5syx5w7d8y1h6wrj0nrm0000gn/T/RtmpXyTvRM/remotes8cce2d40434d/sds270-s22-ftirsr-d361323/DESCRIPTION’ ...  ✔  checking for file ‘/private/var/folders/5m/f1fw5syx5w7d8y1h6wrj0nrm0000gn/T/RtmpXyTvRM/remotes8cce2d40434d/sds270-s22-ftirsr-d361323/DESCRIPTION’
#>   ─  preparing ‘ftirsr’:
#>      checking DESCRIPTION meta-information ...  ✔  checking DESCRIPTION meta-information
#>   ─  checking for LF line-endings in source and make files and shell scripts
#>   ─  checking for empty or unneeded directories
#>   ─  building ‘ftirsr_0.0.0.9001.tar.gz’
#>      
#> 
```

## Example

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
# This shows how to read a directory without interpolation
# Note the difference in wavenumbers
my_data_no_interp <- read_ftirs(dir_path = "~/ftirsr/tests/testthat/test_samples",
                      wet_chem_path = "~/ftirsr/tests/testthat/wet-chem-data.csv",
                      interpolate = FALSE)

head(my_data_no_interp)
#> # A tibble: 6 × 4
#>   sample_id   bsi wavenumber absorbance
#>   <chr>     <dbl>      <dbl>      <dbl>
#> 1 FISK-10.0  20.4      7497.    0.00751
#> 2 FISK-10.0  20.4      7495.    0.00828
#> 3 FISK-10.0  20.4      7493.    0.0083 
#> 4 FISK-10.0  20.4      7491.    0.00709
#> 5 FISK-10.0  20.4      7489.    0.00456
#> 6 FISK-10.0  20.4      7487.    0.00264
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

``` r
# We can specify the number of components we want to see, as this is inherited from the predict.mvr method
preds <- predict(my_data_wide, ncomp = 4)
preds
#>    sample_id bsi.4 comps
#> 1  FISK-10.0    17.77782
#> 2 FISK-110.0    13.85117
#> 3 FISK-270.0    15.77409
```

``` r
# If we want to see the details of the training model, we can call arctic_mod() 
mod <- arctic_mod()
summary(mod)
#> Data:    X dimension: 128 1881 
#>  Y dimension: 128 1
#> Fit method: kernelpls
#> Number of components considered: 10
#> 
#> VALIDATION: RMSEP
#> Cross-validated using 10 random segments.
#>        (Intercept)  1 comps  2 comps  3 comps  4 comps  5 comps  6 comps
#> CV           6.848    4.529    4.288    4.146    3.948    3.871    3.854
#> adjCV        6.848    4.527    4.279    4.141    3.936    3.847    3.825
#>        7 comps  8 comps  9 comps  10 comps
#> CV       4.034    4.039    3.873     3.977
#> adjCV    3.963    3.966    3.806     3.897
#> 
#> TRAINING: % variance explained
#>      1 comps  2 comps  3 comps  4 comps  5 comps  6 comps  7 comps  8 comps
#> X      76.96    84.01     90.2    93.13    94.83    97.28    97.51    97.88
#> bsi    56.53    64.18     67.9    72.45    76.19    77.71    81.44    82.70
#>      9 comps  10 comps
#> X      98.12     98.48
#> bsi    84.22     85.08

# We can also use this to create plots with predictions
pplot <- pls::predplot(mod,  newdata =  my_data_wide, asp = 1, line = TRUE)
```

<img src="man/figures/README-unnamed-chunk-10-1.png" width="100%" />

``` r
pplot
#>            measured predicted
#> FISK-10.0     20.37  15.79963
#> FISK-110.0    11.82  14.32237
#> FISK-270.0    11.29  15.13158
```

``` r
# It is also possible to read a single sample file using read_ftirs_file()

one_sample <- read_ftirs_file(single_filepath = "~/ftirsr/tests/testthat/test_samples/FISK-10.0.csv")

head(one_sample)
#>   wavenumber   absorbance sample_id
#> 1       3996 0.0007000000 FISK-10.0
#> 2       3994 0.0007020861 FISK-10.0
#> 3       3992 0.0006977220 FISK-10.0
#> 4       3991 0.0006717982 FISK-10.0
#> 5       3989 0.0006199506 FISK-10.0
#> 6       3987 0.0005513442 FISK-10.0
```
