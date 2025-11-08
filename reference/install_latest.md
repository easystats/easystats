# Install the easystats suite from R-universe (GitHub) or CRAN

This function can be used to install all the **easystats** packages,
either latest development versions (from R-universe/GitHub) or the
current versions from CRAN. If the development versions are installed,
packages will be installed from the stable branch (master/main) for each
package.

## Usage

``` r
install_latest(
  source = "development",
  packages = "all",
  force = FALSE,
  verbose = TRUE
)
```

## Arguments

- source:

  Character. Either `"development"`, `"cran"` or `"github"`. If
  `"cran"`, packages will be installed from the default CRAN mirror
  returned by `getOption("repos")['CRAN']`. If `"development"` (the
  default), packages are installed from the R-universe repository
  (<https://easystats.r-universe.dev/>). `"github"` installs the latest
  version from the GitHub-repositories main-branch. However, this option
  is usually not needed, because R-universe provides latest binaries.
  Use the `"github"` option only when R-universe servers are
  unavailable.

- packages:

  Character vector, indicating which packages to be installed. By
  default, the option `"all"` will install all **easystats** packages.

- force:

  Logical, if `FALSE`, only those packages with a newer version number
  will be installed. Use `force=TRUE` to force installation of all
  packages, even if the version number for the locally installed
  packages is identical to the latest development-versions. Only applies
  when `source="development"`.

- verbose:

  Toggle messages.

## Value

Invisible `NULL`.

## Examples

``` r
if (FALSE) {
# install latest development-version of easystats packages from
# the r-universe repository, but only those packages that have newer
# versions available
install_latest()

# install all latest development-version of easystats packages from
# the r-universe repository, no matter whether local installations
# are up to date or not.
install_latest(force = TRUE)
}
```
