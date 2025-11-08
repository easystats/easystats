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
#> insight     |  9,222,596 | 115,282
#> datawizard  |  6,027,160 | 113,720
#> performance |  4,031,428 |  51,031
#> parameters  |  4,016,664 |  53,556
#> bayestestR  |  3,924,518 |  49,677
#> effectsize  |  3,001,165 |  41,683
#> correlation |  1,122,473 |  16,507
#> see         |    892,226 |  11,439
#> modelbased  |    618,676 |   8,838
#> report      |    318,480 |   5,791
#> easystats   |    133,818 |   3,431
#> Total       | 33,309,204 | 470,955
# }
```
