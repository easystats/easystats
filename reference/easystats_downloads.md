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
#> insight     | 10,514,585 | 122,263
#> datawizard  |  7,015,347 | 118,904
#> performance |  4,775,571 |  56,183
#> parameters  |  4,633,145 |  57,199
#> bayestestR  |  4,566,007 |  53,718
#> effectsize  |  3,437,564 |  44,071
#> correlation |  1,295,588 |  17,508
#> see         |  1,047,059 |  12,465
#> modelbased  |    768,285 |  10,109
#> report      |    390,006 |   6,394
#> easystats   |    175,799 |   3,907
#> Total       | 38,618,956 | 502,721
# }
```
