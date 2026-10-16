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
#> insight     | 11,352,778 | 124,756
#> datawizard  |  7,655,891 | 119,623
#> performance |  5,274,348 |  58,604
#> parameters  |  5,041,320 |  58,620
#> bayestestR  |  5,041,274 |  56,014
#> effectsize  |  3,745,653 |  45,128
#> correlation |  1,421,076 |  17,988
#> see         |  1,170,399 |  13,151
#> modelbased  |    884,910 |  10,925
#> report      |    429,127 |   6,502
#> easystats   |    204,672 |   4,093
#> Total       | 42,221,448 | 515,404
# }
```
