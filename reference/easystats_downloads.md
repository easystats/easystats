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
#> insight     | 11,372,259 | 124,970
#> datawizard  |  7,669,887 | 119,842
#> performance |  5,285,019 |  58,722
#> bayestestR  |  5,052,956 |  56,144
#> parameters  |  5,051,578 |  58,739
#> effectsize  |  3,752,390 |  45,210
#> correlation |  1,424,210 |  18,028
#> see         |  1,173,699 |  13,188
#> modelbased  |    887,769 |  10,960
#> report      |    430,198 |   6,518
#> easystats   |    205,301 |   4,106
#> Total       | 42,305,266 | 516,427
# }
```
