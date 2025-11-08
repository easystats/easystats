# R version support

R evolves every year. Each update brings many bug fixes and performance
improvements, but also sometimes changes the default value of some
parameters (such as switching from `stringsAsFactors = TRUE` to `FALSE`
in R 4.0.0).

While there is benefit in supporting older R versions, doing so adds
maintenance burden, especially in a large ecosystem like **easystats**
that contains 10 packages that are supposed to seamlessly work together.
Therefore, **easystats** is supported (meaning each package is
thoroughly tested) on the **current R** version, the future one
(**R-devel**) and the **previous five** versions.

The [current planned release schedule for large R
updates](https://developer.r-project.org/) is once a year in Spring.
Accordingly, this table shows the corresponding latest R version and the
oldest supported version:

| Year | Latest R version | Oldest supported R version |
|------|------------------|----------------------------|
| 2023 | 4.3              | 3.5                        |
| 2024 | 4.4              | 3.6                        |
| 2025 | 4.5              | 4.0                        |
| 2026 | 4.6              | 4.1                        |
| 2027 | 4.7              | 4.2                        |
| 2028 | 4.8              | 4.3                        |

(Of course, if the R release schedule changes or R releases a “5.0”
version, the numbers in the table will change.)

## Implications

The implications are simple:

- If you are a user and your R version is below the oldest supported
  one, you must update it to use the **easystats** packages.
  Alternatively, you can also download a version of the package that is
  compatible with your R version from the [CRAN
  archive](https://cran.r-project.org/src/contrib/Archive/) and then
  install it locally. Finally, the package
  [remotes](https://remotes.r-lib.org) gives a way to install an old
  version of a package. For instance,
  `remotes::install_version("insight", version = "0.10.0")` installs a
  version of [insight](https://easystats.github.io/insight/) that is
  compatible with R 3.5.0.

- If you are a developer and your package depends on one of the
  **easystats** packages, the oldest version that your package supports
  corresponds to the oldest version supported by **easystats**. Note
  that this should be reflected in your DESCRIPTION file with
  `Depends: R (>= x.y.z)`.
