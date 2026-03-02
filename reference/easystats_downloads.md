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
#> insight     |  9,934,524 | 119,693
#> datawizard  |  6,569,571 | 117,314
#> performance |  4,449,029 |  54,256
#> parameters  |  4,354,366 |  55,825
#> bayestestR  |  4,274,779 |  52,131
#> effectsize  |  3,233,001 |  43,107
#> correlation |  1,222,885 |  17,224
#> see         |    983,287 |  12,139
#> modelbased  |    706,827 |   9,683
#> report      |    361,291 |   6,229
#> easystats   |    156,960 |   3,737
#> Total       | 36,246,520 | 491,338
# }
```
