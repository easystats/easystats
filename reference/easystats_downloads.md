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
#> insight     |  9,771,849 | 117,733
#> datawizard  |  6,453,018 | 115,232
#> performance |  4,353,934 |  53,097
#> parameters  |  4,283,081 |  54,911
#> bayestestR  |  4,199,888 |  51,218
#> effectsize  |  3,184,944 |  42,466
#> correlation |  1,203,204 |  16,947
#> see         |    963,280 |  11,892
#> modelbased  |    688,688 |   9,434
#> report      |    352,377 |   6,075
#> easystats   |    151,758 |   3,613
#> Total       | 35,606,021 | 482,618
# }
```
