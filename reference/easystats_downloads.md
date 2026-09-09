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
#> insight     | 11,120,811 | 123,565
#> datawizard  |  7,477,988 | 118,698
#> performance |  5,135,802 |  57,706
#> parameters  |  4,930,201 |  58,002
#> bayestestR  |  4,907,156 |  55,137
#> effectsize  |  3,662,884 |  44,669
#> correlation |  1,384,578 |  17,751
#> see         |  1,134,085 |  12,887
#> modelbased  |    849,752 |  10,622
#> report      |    418,865 |   6,444
#> easystats   |    196,205 |   4,004
#> Total       | 41,218,327 | 509,485
# }
```
