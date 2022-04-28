
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![R-CMD-check](https://github.com/sds270-s22/ftirsr/workflows/R-CMD-check/badge.svg)](https://github.com/sds270-s22/ftirsr/actions)

[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)

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
#>      checking for file ‘/private/var/folders/5m/f1fw5syx5w7d8y1h6wrj0nrm0000gn/T/RtmpZoXVWR/remotes435f3d3f9342/sds270-s22-ftirsr-b9ab86a/DESCRIPTION’ ...  ✔  checking for file ‘/private/var/folders/5m/f1fw5syx5w7d8y1h6wrj0nrm0000gn/T/RtmpZoXVWR/remotes435f3d3f9342/sds270-s22-ftirsr-b9ab86a/DESCRIPTION’ (402ms)
#>   ─  preparing ‘ftirsr’:
#>      checking DESCRIPTION meta-information ...  ✔  checking DESCRIPTION meta-information
#>   ─  checking for LF line-endings in source and make files and shell scripts
#>   ─  checking for empty or unneeded directories
#>       ─  building ‘ftirsr_0.0.0.9001.tar.gz’
#>      
#> 
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(ftirsr)

# This shows finding the maximum biogenic silica percentage in the dataset
max(greenland$bsi)
#> [1] 30.61
```
