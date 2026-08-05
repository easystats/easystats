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
#> insight     | 10,935,694 | 122,873
#> datawizard  |  7,340,273 | 118,392
#> performance |  5,024,146 |  57,093
#> parameters  |  4,840,603 |  57,626
#> bayestestR  |  4,804,231 |  54,594
#> effectsize  |  3,592,203 |  44,348
#> correlation |  1,352,023 |  17,559
#> see         |  1,101,921 |  12,666
#> modelbased  |    818,078 |  10,355
#> report      |    409,714 |   6,402
#> easystats   |    189,045 |   3,938
#> Total       | 40,407,931 | 505,846
# }
```
