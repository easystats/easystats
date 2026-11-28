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
#> Choosing informative priors in... |   Frontiers in Psychology | 2026 |      3
#> modelbased: An R package to...    | Journal of Open Source... | 2025 |    185
#> Check your outliers﻿! An...        | Behavior Research Methods | 2024 |     87
#> Phi, Fei, Fo, Fum: effect...      |               Mathematics | 2023 |     95
#> datawizard: An R package for...   | Journal of Open Source... | 2022 |     85
#> performance: An R package for...  | Journal of Open Source... | 2021 |  8,621
#> see: An R package for...          | Journal of Open Source... | 2021 |    205
#> effectsize: Estimation of...      | Journal of open source... | 2020 |  3,026
#> Methods and algorithms for...     | Journal of Open Source... | 2020 |  1,009
#> Extracting, computing and...      | Journal of Open Source... | 2020 |    755
#> The {easystats} collection of...  |                    GitHub | 2020 |    182
#> bayestestR: Describing Effects... | Journal of Open Source... | 2019 |  2,135
#> Indices of Effect Existence...    |   Frontiers in Psychology | 2019 |  1,320
#> insight: A Unified Interface...   | Journal of Open Source... | 2019 |    180
#> The report package for R:...      |                      CRAN | 2019 |     66
#> Total                             |                           |      | 17,954
# }
```
