# List all news from development versions

This function returns a list with all news from the latest development
packages' versions that are not yet on CRAN.

## Usage

``` r
easystats_whatsnew(packages = "all")
```

## Arguments

- packages:

  String, name of the easystats-package, or `"all"` to include all
  packages.

## Value

A table (object of class *gt*), printed to the viewer pane.
