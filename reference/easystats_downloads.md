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
#> insight     | 11,973,058 | 131,572
#> datawizard  |  8,026,615 | 125,416
#> performance |  5,544,379 |  61,604
#> bayestestR  |  5,348,643 |  59,429
#> parameters  |  5,290,518 |  61,518
#> effectsize  |  3,926,538 |  47,308
#> correlation |  1,494,062 |  18,912
#> see         |  1,231,629 |  13,839
#> modelbased  |    949,879 |  11,727
#> report      |    449,360 |   6,808
#> easystats   |    216,534 |   4,331
#> Total       | 44,451,215 | 542,464
# }
```
