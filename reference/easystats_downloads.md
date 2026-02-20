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
#> insight     |  9,866,143 | 118,869
#> datawizard  |  6,517,624 | 116,386
#> performance |  4,408,517 |  53,762
#> parameters  |  4,322,381 |  55,415
#> bayestestR  |  4,240,952 |  51,719
#> effectsize  |  3,211,195 |  42,816
#> correlation |  1,214,115 |  17,100
#> see         |    975,000 |  12,037
#> modelbased  |    697,984 |   9,561
#> report      |    357,521 |   6,164
#> easystats   |    154,697 |   3,683
#> Total       | 35,966,129 | 487,512
# }
```
