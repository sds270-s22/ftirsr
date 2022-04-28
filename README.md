
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
#> colorspace   (2.0-0  -> 2.0-3 ) [CRAN]
#> viridisLite  (0.3.0  -> 0.4.0 ) [CRAN]
#> RColorBrewer (1.1-2  -> 1.1-3 ) [CRAN]
#> farver       (2.0.3  -> 2.1.0 ) [CRAN]
#> scales       (1.1.1  -> 1.2.0 ) [CRAN]
#> isoband      (0.2.3  -> 0.2.5 ) [CRAN]
#> digest       (0.6.27 -> 0.6.29) [CRAN]
#> yaml         (2.2.1  -> 2.3.5 ) [CRAN]
#> highr        (0.8    -> 0.9   ) [CRAN]
#> evaluate     (0.14   -> 0.15  ) [CRAN]
#> knitr        (1.31   -> 1.39  ) [CRAN]
#> Installing 11 packages: colorspace, viridisLite, RColorBrewer, farver, scales, isoband, digest, yaml, highr, evaluate, knitr
#> 
#>   There are binary versions available but the source versions are later:
#>        binary source needs_compilation
#> scales  1.1.1  1.2.0             FALSE
#> knitr    1.38   1.39             FALSE
#> 
#> 
#> The downloaded binary packages are in
#>  /var/folders/5m/f1fw5syx5w7d8y1h6wrj0nrm0000gn/T//RtmpEfmgDL/downloaded_packages
#> installing the source packages 'scales', 'knitr'
#>      checking for file ‘/private/var/folders/5m/f1fw5syx5w7d8y1h6wrj0nrm0000gn/T/RtmpEfmgDL/remotes3c1b433ad6c9/sds270-s22-ftirsr-770f572/DESCRIPTION’ ...  ✔  checking for file ‘/private/var/folders/5m/f1fw5syx5w7d8y1h6wrj0nrm0000gn/T/RtmpEfmgDL/remotes3c1b433ad6c9/sds270-s22-ftirsr-770f572/DESCRIPTION’
#>   ─  preparing ‘ftirsr’:
#>      checking DESCRIPTION meta-information ...  ✔  checking DESCRIPTION meta-information
#>      Warning: /private/var/folders/5m/f1fw5syx5w7d8y1h6wrj0nrm0000gn/T/RtmpPzqpsC/Rbuild3c825961d4de/ftirsr/man/as.ftirs.Rd:8: unexpected section header '\name'
#>    Warning: /private/var/folders/5m/f1fw5syx5w7d8y1h6wrj0nrm0000gn/T/RtmpPzqpsC/Rbuild3c825961d4de/ftirsr/man/as.ftirs.Rd:9: unexpected section header '\alias'
#>    Warning: /private/var/folders/5m/f1fw5syx5w7d8y1h6wrj0nrm0000gn/T/RtmpPzqpsC/Rbuild3c825961d4de/ftirsr/man/as.ftirs.Rd:10: unexpected section header '\title'
#>      Warning: /private/var/folders/5m/f1fw5syx5w7d8y1h6wrj0nrm0000gn/T/RtmpPzqpsC/Rbuild3c825961d4de/ftirsr/man/as.ftirs.Rd:13: unexpected section header '\usage'
#>    Warning: /private/var/folders/5m/f1fw5syx5w7d8y1h6wrj0nrm0000gn/T/RtmpPzqpsC/Rbuild3c825961d4de/ftirsr/man/as.ftirs.Rd:16: unexpected section header '\arguments'
#>    Warning: /private/var/folders/5m/f1fw5syx5w7d8y1h6wrj0nrm0000gn/T/RtmpPzqpsC/Rbuild3c825961d4de/ftirsr/man/as.ftirs.Rd:17: unknown macro '\item'
#>    Warning: /private/var/folders/5m/f1fw5syx5w7d8y1h6wrj0nrm0000gn/T/RtmpPzqpsC/Rbuild3c825961d4de/ftirsr/man/as.ftirs.Rd:19: unexpected section header '\description'
#>    Warning: /private/var/folders/5m/f1fw5syx5w7d8y1h6wrj0nrm0000gn/T/RtmpPzqpsC/Rbuild3c825961d4de/ftirsr/man/as.ftirs.Rd:27: unexpected END_OF_INPUT '
#>    '
#>      Warning: /private/var/folders/5m/f1fw5syx5w7d8y1h6wrj0nrm0000gn/T/RtmpPzqpsC/Rbuild3c825961d4de/ftirsr/man/read_wet_chem.Rd:8: unexpected section header '\title'
#>    Warning: /private/var/folders/5m/f1fw5syx5w7d8y1h6wrj0nrm0000gn/T/RtmpPzqpsC/Rbuild3c825961d4de/ftirsr/man/read_wet_chem.Rd:11: unexpected section header '\usage'
#>      Warning: /private/var/folders/5m/f1fw5syx5w7d8y1h6wrj0nrm0000gn/T/RtmpPzqpsC/Rbuild3c825961d4de/ftirsr/man/read_wet_chem.Rd:14: unexpected section header '\arguments'
#>    Warning: /private/var/folders/5m/f1fw5syx5w7d8y1h6wrj0nrm0000gn/T/RtmpPzqpsC/Rbuild3c825961d4de/ftirsr/man/read_wet_chem.Rd:15: unknown macro '\item'
#>    Warning: /private/var/folders/5m/f1fw5syx5w7d8y1h6wrj0nrm0000gn/T/RtmpPzqpsC/Rbuild3c825961d4de/ftirsr/man/read_wet_chem.Rd:17: unknown macro '\item'
#>    Warning: /private/var/folders/5m/f1fw5syx5w7d8y1h6wrj0nrm0000gn/T/RtmpPzqpsC/Rbuild3c825961d4de/ftirsr/man/read_wet_chem.Rd:19: unknown macro '\item'
#>    Warning: /private/var/folders/5m/f1fw5syx5w7d8y1h6wrj0nrm0000gn/T/RtmpPzqpsC/Rbuild3c825961d4de/ftirsr/man/read_wet_chem.Rd:21: unexpected section header '\description'
#>    Warning: /private/var/folders/5m/f1fw5syx5w7d8y1h6wrj0nrm0000gn/T/RtmpPzqpsC/Rbuild3c825961d4de/ftirsr/man/read_wet_chem.Rd:29: unexpected END_OF_INPUT '
#>    '
#>   ─  checking for LF line-endings in source and make files and shell scripts
#>   ─  checking for empty or unneeded directories
#>   ─  building ‘ftirsr_0.0.0.9001.tar.gz’
#>      
#> 
#> Warning in i.p(...): installation of package '/var/folders/5m/
#> f1fw5syx5w7d8y1h6wrj0nrm0000gn/T//RtmpEfmgDL/file3c1b6aa897c9/
#> ftirsr_0.0.0.9001.tar.gz' had non-zero exit status
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(ftirsr)

# This shows finding the maximum biogenic silica percentage in the dataset
max(greenland$bsi)
#> [1] 30.61
```
