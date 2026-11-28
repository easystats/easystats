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
#> insight     | 12,134,176 | 131,893
#> datawizard  |  8,154,567 | 125,455
#> performance |  5,642,911 |  62,010
#> bayestestR  |  5,442,669 |  59,810
#> parameters  |  5,369,956 |  61,724
#> effectsize  |  3,983,411 |  47,422
#> correlation |  1,517,884 |  18,974
#> see         |  1,253,813 |  13,931
#> modelbased  |    972,183 |  11,856
#> report      |    457,677 |   6,831
#> easystats   |    222,759 |   4,368
#> Total       | 45,152,006 | 544,274
# }
```
