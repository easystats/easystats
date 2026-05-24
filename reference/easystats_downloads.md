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
#> insight     | 10,509,883 | 122,208
#> datawizard  |  7,011,925 | 118,846
#> performance |  4,772,928 |  56,152
#> parameters  |  4,631,168 |  57,175
#> bayestestR  |  4,563,272 |  53,686
#> effectsize  |  3,436,072 |  44,052
#> correlation |  1,295,057 |  17,501
#> see         |  1,046,634 |  12,460
#> modelbased  |    767,806 |  10,103
#> report      |    389,775 |   6,390
#> easystats   |    175,653 |   3,903
#> Total       | 38,600,173 | 502,476
# }
```
