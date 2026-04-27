# Reports download statistics for easystats packages

This function reports download statistics for `easystats` packages from
CRAN through the `cranlogs` package.

## Usage

``` r
easystats_downloads(from = "2019-02-26", sort_by = "total", length = 30)
```

## Arguments

- from:

  Starting date for the download statistics. Defaults to `"2019-02-26"`,
  which is when the first easystats package was released on CRAN.

- sort_by:

  Name of the column that should be used for sorting. Can be
  `"package"`, `"total"`, or `"monthly"`. Use `NULL` for no sorting.
  Defaults to `"total"` (total downloads).

- length:

  Numeric, maximum length of the returned string. If not `NULL`, will
  shorten the string to a maximum `length`, however, it will not
  truncate inside words. I.e. if the string length happens to be inside
  a word, this word is removed from the returned string, so the returned
  string has a *maximum* length of `length`, but might be shorter.

## Value

A data frame with three columns: package, total downloads, and average
monthly downloads.

## Examples

``` r
# \dontrun{
easystats_downloads()
#> Package     |      Total | Monthly
#> ----------------------------------
#> insight     | 10,307,619 | 121,266
#> datawizard  |  6,845,350 | 118,023
#> performance |  4,659,354 |  55,468
#> parameters  |  4,528,579 |  56,607
#> bayestestR  |  4,458,789 |  53,081
#> effectsize  |  3,365,031 |  43,702
#> correlation |  1,269,259 |  17,387
#> see         |  1,025,068 |  12,350
#> modelbased  |    745,162 |   9,935
#> report      |    378,178 |   6,303
#> easystats   |    168,200 |   3,823
#> Total       | 37,750,589 | 497,945
# }
```
