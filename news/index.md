# Changelog

## easystats 0.7.6

- [`library(easystats)`](https://easystats.github.io/easystats/) is now
  faster for bad internet connections.

- [`library(easystats)`](https://easystats.github.io/easystats/) now
  politely respects arguments `quietly = TRUE` and `verbose = FALSE` to
  hide startup messages.

## easystats 0.7.5

CRAN release: 2025-07-11

- New function
  [`easystats_citations()`](https://easystats.github.io/easystats/reference/easystats_citations.md)
  to report the total number of Google Scholar citations for `easystats`
  publications.

- New function
  [`easystats_downloads()`](https://easystats.github.io/easystats/reference/easystats_downloads.md)
  to report download statistics for `easystats` packages from CRAN.

- The `source` argument in
  [`install_latest()`](https://easystats.github.io/easystats/reference/install_latest.md)
  gets a `"github"` option, to install the latest version from the
  GitHub-repositories main-branch. Usually, this is not needed, because
  r-universe provides latest binaries.

## easystats 0.7.4

CRAN release: 2025-02-06

- Added a new vignette, *A complete workflow using easystats*.

- [`install_suggested()`](https://easystats.github.io/easystats/reference/install_suggested.md)
  did not install required hard-dependencies for suggested packages.
  This is fixed now, thanks to
  [@viv-analytics](https://github.com/viv-analytics).

- Minor changes, fixes to broken URLs.

## easystats 0.7.3

CRAN release: 2024-07-22

- New function
  [`easystats_packages()`](https://easystats.github.io/easystats/reference/easystats_packages.md)
  that produces a character vector with the names of all packages in the
  `easystats` ecosystem
  ([\#417](https://github.com/easystats/easystats/issues/417)).

- Updated [`citation()`](https://rdrr.io/r/utils/citation.html)
  information.

- [`easystats_update()`](https://easystats.github.io/easystats/reference/easystats_update.md)
  and
  [`install_suggested()`](https://easystats.github.io/easystats/reference/install_suggested.md)
  now use the *pak* package, if this is installed.

## easystats 0.7.2

CRAN release: 2024-06-06

- Add a vignette on the R version policy for all packages in the
  **easystats** ecosystem
  ([\#403](https://github.com/easystats/easystats/issues/403)).

- Fixed CRAN check issues.

## easystats 0.7.1

CRAN release: 2024-03-28

### Bug fix

- Fixed issue with detecting correct version of development packages
  when version numbers on CRAN and GitHub were identical.

## easystats 0.7.0

CRAN release: 2023-11-05

### Major Changes

- Given their significant contributions throughout the ecosystem, the
  package gains two new authors: [Etienne
  Bacher](https://github.com/etiennebacher) and [Rémi
  Thériault](https://github.com/rempsyc). Welcome on-board!

- This release changes the licensing model of
  [easystats](https://easystats.github.io/easystats/) to an MIT license.

- All component packages have been bumped to their latest versions.

### Minor Changes

- [`model_dashboard()`](https://easystats.github.io/easystats/reference/model_dashboard.md)
  gains a new argument `browse_html` to control if the rendered
  dashboard is opened in the browser.

## easystats 0.6.0

CRAN release: 2022-11-29

### Breaking Changes

- The minimum needed R version has been bumped to `3.6`.

- Following functions have been removed since they are not expected to
  be of any relevance for the users:

  - `CRAN_checks()`
  - `on_CRAN()`

### Major Changes

- All hard dependencies have been bumped to their latest versions.

- The
  [`model_dashboard()`](https://easystats.github.io/easystats/reference/model_dashboard.md)
  is now less verbose when some of the various functions do not support
  the provided model class, to keep the output clean.

- The
  [`model_dashboard()`](https://easystats.github.io/easystats/reference/model_dashboard.md)
  now better captures errors and providing more informative messages on
  how to seek help.

- Fixed NOTEs in CRAN checks.

## easystats 0.5.2

CRAN release: 2022-08-30

- Initial CRAN submission.

## easystats 0.5.1

- [`install_latest()`](https://easystats.github.io/easystats/reference/install_latest.md)
  gains a `force` argument, to either force all packages to be updates,
  or only update locally installed packages where newer versions are
  available.

## easystats 0.5.0

- Adds new
  [`model_dashboard()`](https://easystats.github.io/easystats/reference/model_dashboard.md)
  function to generate a dashboard with regression model summary from
  [easystats](https://easystats.github.io/easystats/).

- Bumps needed minimum R version to `3.5`.

- Updates minimum needed versions of all packages to the latest
  versions.

## easystats 0.4.1

- Adds *datawizard* package.

- Adds a new function
  [`install_suggested()`](https://easystats.github.io/easystats/reference/install_suggested.md)
  to install suggested packages.

## easystats 0.4.0

- Includes a new package for automated reporting of statistical
  analyses: `report`.

- Moves `rvest`, `xml2`, and `remotes` from `Imports` to `Suggests`.

## easystats 0.3.0

- Revised startup-messages, so these can be suppressed by using
  [`suppressPackageStartupMessages()`](https://rdrr.io/r/base/message.html).

- The CRAN-check for errors or warnings in `easystats`-packages is no
  longer shown by default on startup. Use
  `easystats::check_cran_status()` to see them.
