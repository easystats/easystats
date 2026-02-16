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
#> insight     |  9,852,929 | 118,710
#> datawizard  |  6,508,020 | 116,215
#> performance |  4,401,000 |  53,671
#> parameters  |  4,316,457 |  55,339
#> bayestestR  |  4,234,679 |  51,642
#> effectsize  |  3,207,171 |  42,762
#> correlation |  1,212,501 |  17,077
#> see         |    973,437 |  12,018
#> modelbased  |    696,408 |   9,540
#> report      |    356,813 |   6,152
#> easystats   |    154,261 |   3,673
#> Total       | 35,913,676 | 486,799
# }
```
