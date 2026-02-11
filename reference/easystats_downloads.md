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
#> insight     |  9,814,423 | 118,246
#> datawizard  |  6,480,367 | 115,721
#> performance |  4,378,989 |  53,402
#> parameters  |  4,299,528 |  55,122
#> bayestestR  |  4,216,891 |  51,426
#> effectsize  |  3,196,392 |  42,619
#> correlation |  1,207,951 |  17,013
#> see         |    968,851 |  11,961
#> modelbased  |    692,750 |   9,490
#> report      |    354,710 |   6,116
#> easystats   |    153,135 |   3,646
#> Total       | 35,763,987 | 484,762
# }
```
