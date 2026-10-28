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
#> insight     | 11,427,454 | 125,576
#> datawizard  |  7,715,537 | 120,555
#> performance |  5,319,264 |  59,103
#> bayestestR  |  5,086,741 |  56,519
#> parameters  |  5,080,282 |  59,073
#> effectsize  |  3,771,589 |  45,441
#> correlation |  1,432,200 |  18,129
#> see         |  1,181,620 |  13,277
#> modelbased  |    895,634 |  11,057
#> report      |    433,608 |   6,570
#> easystats   |    207,081 |   4,142
#> Total       | 42,551,010 | 519,442
# }
```
