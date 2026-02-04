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
#> insight     |  9,763,926 | 117,638
#> datawizard  |  6,447,095 | 115,127
#> performance |  4,349,302 |  53,040
#> parameters  |  4,279,464 |  54,865
#> bayestestR  |  4,196,169 |  51,173
#> effectsize  |  3,182,371 |  42,432
#> correlation |  1,202,193 |  16,932
#> see         |    962,016 |  11,877
#> modelbased  |    687,849 |   9,423
#> report      |    351,890 |   6,067
#> easystats   |    151,452 |   3,606
#> Total       | 35,573,727 | 482,180
# }
```
