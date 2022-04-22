
<!-- README.md is generated from README.Rmd. Please edit that file -->

# plsr

The goal of `plsr` is to help easily create a Partial Least Squares
Regression model to estimate composition of natural compounds such as
biogenic silica and total organic carbon in lake sediment core samples.

## Installation

The development version from GitHub can be accessed like so:

``` r
remotes::install_github("sds270-s22/plsr")
#> Downloading GitHub repo sds270-s22/plsr@HEAD
#>      checking for file ‘/private/var/folders/5m/f1fw5syx5w7d8y1h6wrj0nrm0000gn/T/RtmpfneiBf/remotes15d6c1d88b62/sds270-s22-plsr-7db18bc/DESCRIPTION’ ...  ✓  checking for file ‘/private/var/folders/5m/f1fw5syx5w7d8y1h6wrj0nrm0000gn/T/RtmpfneiBf/remotes15d6c1d88b62/sds270-s22-plsr-7db18bc/DESCRIPTION’
#>   ─  preparing ‘plsr’:
#>      checking DESCRIPTION meta-information ...  ✓  checking DESCRIPTION meta-information
#>   ─  checking for LF line-endings in source and make files and shell scripts
#>   ─  checking for empty or unneeded directories
#>   ─  building ‘plsr_0.0.0.9001.tar.gz’
#>      
#> 
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(plsr)

# This shows finding the maximum biogenic silica percentage in the dataset
max(greenland$bsi)
#> [1] 30.61
```
