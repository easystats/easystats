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
#> modelbased: An R package to...    | Journal of Open Source... | 2025 |    107
#> Choosing informative priors in... |                           | 2025 |      0
#> Check your outliers! An...        | Behavior Research Methods | 2024 |     47
#> Phi, Fei, Fo, Fum: effect...      |               Mathematics | 2023 |     36
#> datawizard: An R package for...   | Journal of Open Source... | 2022 |     57
#> performance: An R package for...  | Journal of Open Source... | 2021 |  5,490
#> see: An R package for...          | Journal of Open Source... | 2021 |    141
#> effectsize: Estimation of...      | Journal of open source... | 2020 |  1,961
#> Methods and algorithms for...     | Journal of Open Source... | 2020 |    783
#> Extracting, computing and...      | Journal of Open Source... | 2020 |    532
#> The {easystats} collection of...  |                    GitHub | 2020 |    113
#> bayestestR: Describing Effects... | Journal of Open Source... | 2019 |  1,578
#> Indices of Effect Existence...    |   Frontiers in Psychology | 2019 |    932
#> insight: A Unified Interface...   | Journal of Open Source... | 2019 |    141
#> The report package for R:...      |                      CRAN | 2019 |     55
#> Total                             |                           |      | 11,973
# }
```
