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
#> insight     | 11,129,445 | 123,660
#> datawizard  |  7,484,182 | 118,797
#> performance |  5,141,122 |  57,765
#> parameters  |  4,934,460 |  58,052
#> bayestestR  |  4,911,985 |  55,191
#> effectsize  |  3,666,008 |  44,707
#> correlation |  1,386,421 |  17,775
#> see         |  1,135,928 |  12,908
#> modelbased  |    851,528 |  10,644
#> report      |    419,187 |   6,449
#> easystats   |    196,484 |   4,010
#> Total       | 41,256,750 | 509,958
# }
```
