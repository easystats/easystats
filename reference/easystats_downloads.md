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
#> insight     | 12,113,612 | 131,670
#> datawizard  |  8,138,970 | 125,215
#> performance |  5,630,169 |  61,870
#> bayestestR  |  5,431,038 |  59,682
#> parameters  |  5,360,303 |  61,613
#> effectsize  |  3,976,340 |  47,337
#> correlation |  1,514,767 |  18,935
#> see         |  1,251,118 |  13,901
#> modelbased  |    969,151 |  11,819
#> report      |    456,446 |   6,813
#> easystats   |    222,089 |   4,355
#> Total       | 45,064,003 | 543,210
# }
```
