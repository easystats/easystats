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
#> insight     |  9,363,687 | 117,046
#> datawizard  |  6,137,665 | 115,805
#> performance |  4,112,142 |  52,052
#> parameters  |  4,086,917 |  54,492
#> bayestestR  |  4,001,427 |  50,651
#> effectsize  |  3,050,893 |  42,374
#> correlation |  1,143,760 |  16,820
#> see         |    910,914 |  11,678
#> modelbased  |    634,912 |   9,070
#> report      |    326,624 |   5,939
#> easystats   |    137,650 |   3,529
#> Total       | 33,906,591 | 479,456
# }
```
