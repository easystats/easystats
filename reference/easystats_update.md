# Update *easystats*-packages and its dependencies from CRAN, if necessary.

Update *easystats*-packages and its dependencies from CRAN, if
necessary.

## Usage

``` r
easystats_update(which = "all")
```

## Arguments

- which:

  String, indicates whether easystats-packages (`which = "core"`),
  dependencies (`which = "deps"`) or both (`which = "all"`) should be
  checked for available updates.

## Value

Invisible `NULL`.

## Details

If package `{pak}` is installed,
[`pak::pkg_install()`](https://pak.r-lib.org/reference/pkg_install.html)
will be used to install packages. Else,
[`utils::install.packages()`](https://rdrr.io/r/utils/install.packages.html)
is used.

## Examples

``` r
if (FALSE) {
# check which local easystats-packages (and their dependencies)
# are out of date and install updates from CRAN
easystats_update()

# update only easystats core-packages
easystats_update("core")
}
```
