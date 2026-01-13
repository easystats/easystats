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
#> insight     |  9,628,617 | 117,422
#> datawizard  |  6,344,656 | 115,357
#> performance |  4,269,582 |  52,711
#> parameters  |  4,217,196 |  54,769
#> bayestestR  |  4,131,906 |  51,011
#> effectsize  |  3,139,242 |  42,422
#> correlation |  1,182,753 |  16,896
#> see         |    944,152 |  11,802
#> modelbased  |    671,467 |   9,326
#> report      |    343,305 |   6,023
#> easystats   |    146,538 |   3,574
#> Total       | 35,019,414 | 481,313
# }
```
