# List all arguments used in easystats packages

This function returns a list with all arguments that are used across all
easystats packages

## Usage

``` r
easystats_arguments(packages = "all", flatten = FALSE)
```

## Arguments

- packages:

  String, name of the easystats-package, or `"all"` to include all
  packages.

- flatten:

  If `TRUE`, returns only one element and each argument only once.

## Value

A named list with argument names used in the different packages.
