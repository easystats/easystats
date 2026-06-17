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
#> insight     | 10,677,902 | 122,735
#> datawizard  |  7,141,788 | 119,030
#> performance |  4,866,306 |  56,585
#> parameters  |  4,712,565 |  57,470
#> bayestestR  |  4,654,097 |  54,117
#> effectsize  |  3,491,678 |  44,198
#> correlation |  1,316,058 |  17,547
#> see         |  1,066,925 |  12,552
#> modelbased  |    785,365 |  10,200
#> report      |    399,267 |   6,440
#> easystats   |    182,224 |   3,961
#> Total       | 39,294,175 | 504,835
# }
```
