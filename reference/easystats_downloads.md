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
#> insight     | 10,797,200 | 122,695
#> datawizard  |  7,233,737 | 118,586
#> performance |  4,938,839 |  56,768
#> parameters  |  4,772,841 |  57,504
#> bayestestR  |  4,722,063 |  54,277
#> effectsize  |  3,536,641 |  44,208
#> correlation |  1,331,923 |  17,525
#> see         |  1,082,087 |  12,582
#> modelbased  |    799,298 |  10,247
#> report      |    405,063 |   6,430
#> easystats   |    186,173 |   3,961
#> Total       | 39,805,865 | 504,783
# }
```
