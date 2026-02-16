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
#> insight     |  9,849,368 | 118,667
#> datawizard  |  6,505,390 | 116,168
#> performance |  4,399,089 |  53,647
#> parameters  |  4,315,025 |  55,321
#> bayestestR  |  4,233,132 |  51,624
#> effectsize  |  3,206,190 |  42,749
#> correlation |  1,212,074 |  17,071
#> see         |    973,046 |  12,013
#> modelbased  |    696,036 |   9,535
#> report      |    356,586 |   6,148
#> easystats   |    154,105 |   3,669
#> Total       | 35,900,041 | 486,612
# }
```
