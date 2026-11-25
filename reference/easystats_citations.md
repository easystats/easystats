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
#> Warning: Google Scholar refused the request (HTTP 403).
#>   This is what happens when requests come from an IP that Google does not
#>   trust, typically a hosted application or a CI runner, and it is not a
#>   problem with the ID or the URL. Carry the session of a browser that can
#>   open the page with set_scholar_cookie(), point the package at a mirror
#>   with set_scholar_mirror(), or run it from a workstation.
#> NULL
# }
```
