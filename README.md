
<!-- README.md is generated from README.Rmd. Please edit that file -->

# plsr

The goal of `plsr` is to facilitate Partial Least Squares Regression on
biogenic silica and organic carbon percentages in lake sediment core
samples.

## Installation

The development version from GitHub can be accessed like so:

``` r
remotes::install_github("sds270-s22/plsr")
#> Skipping install of 'plsr' from a github remote, the SHA1 (b07a8b5b) has not changed since last install.
#>   Use `force = TRUE` to force installation
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(plsr)

# This shows finding the maximum biogenic silica percentage in the dataset
max(greenland$bsi_percent)
#> [1] 30.61
```
