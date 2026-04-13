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
#> insight     | 10,202,934 | 120,035
#> datawizard  |  6,772,445 | 116,766
#> performance |  4,602,736 |  54,794
#> parameters  |  4,481,669 |  56,021
#> bayestestR  |  4,408,758 |  52,485
#> effectsize  |  3,330,342 |  43,251
#> correlation |  1,257,015 |  17,219
#> see         |  1,014,587 |  12,224
#> modelbased  |    735,531 |   9,807
#> report      |    373,933 |   6,232
#> easystats   |    165,443 |   3,760
#> Total       | 37,345,393 | 492,594
# }
```
