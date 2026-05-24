# Reports citations for easystats publications

This function reports the total number of Google Scholar citations for
`easystats` publications through the `scholar` package.

## Usage

``` r
easystats_citations(sort_by = "year", length = 30)
```

## Arguments

- sort_by:

  Name of the column that should be used for sorting. Can be `"title"`,
  `"journal"`, `"year"`, or `"cites"`. Use `NULL` for no sorting and to
  return data as retrieved by Google scholar.

- length:

  Numeric, maximum length of the returned string. If not `NULL`, will
  shorten the string to a maximum `length`, however, it will not
  truncate inside words. I.e. if the string length happens to be inside
  a word, this word is removed from the returned string, so the returned
  string has a *maximum* length of `length`, but might be shorter.

## Value

A data frame of four columns: title, journal, year, and cites.

## Examples

``` r
# \dontrun{
easystats_citations()
#> Title                             |                   Journal | Year |  Cites
#> -----------------------------------------------------------------------------
#> modelbased: An R package to...    | Journal of Open Source... | 2025 |    139
#> Choosing informative priors in... |                           | 2025 |      0
#> Check your outliers! An...        | Behavior Research Methods | 2024 |     64
#> Phi, Fei, Fo, Fum: effect...      |               Mathematics | 2023 |     68
#> datawizard: An R package for...   | Journal of Open Source... | 2022 |     68
#> performance: An R package for...  | Journal of Open Source... | 2021 |  6,942
#> see: An R package for...          | Journal of Open Source... | 2021 |    170
#> performance: an R package for...  |                           | 2021 |     32
#> effectsize: Estimation of...      | Journal of open source... | 2020 |  2,438
#> Methods and algorithms for...     | Journal of Open Source... | 2020 |    919
#> Extracting, computing and...      | Journal of Open Source... | 2020 |    635
#> The {easystats} collection of...  |                    GitHub | 2020 |    149
#> bayestestR: Describing Effects... | Journal of Open Source... | 2019 |  1,822
#> Indices of Effect Existence...    |   Frontiers in Psychology | 2019 |  1,088
#> insight: A Unified Interface...   | Journal of Open Source... | 2019 |    157
#> The report package for R:...      |                      CRAN | 2019 |     72
#> Total                             |                           |      | 14,763
# }
```
