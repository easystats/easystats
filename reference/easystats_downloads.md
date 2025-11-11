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
#> insight     |  9,239,785 | 115,497
#> datawizard  |  6,040,373 | 113,969
#> performance |  4,040,852 |  51,150
#> parameters  |  4,024,547 |  53,661
#> bayestestR  |  3,933,341 |  49,789
#> effectsize  |  3,006,663 |  41,759
#> correlation |  1,125,157 |  16,546
#> see         |    894,560 |  11,469
#> modelbased  |    620,711 |   8,867
#> report      |    319,434 |   5,808
#> easystats   |    134,185 |   3,441
#> Total       | 33,379,608 | 471,956
# }
```
