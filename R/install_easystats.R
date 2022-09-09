#' Install the easystats suite from R-universe (GitHub) or CRAN
#'
#' This function can be used to install all the **easystats** packages, either
#' latest development versions (from R-universe/GitHub) or the current
#' versions from CRAN. If the development versions are installed, packages
#' will be installed from the stable branch (master/main) for each package.
#'
#' @param source Character. Either `"development"` or `"cran"`. If `"cran"`,
#'   packages will be installed from the default CRAN mirror returned by
#'   `getOption("repos")['CRAN']`. If `"development"` (the default), packages
#'   are installed from the r-universe repository (<https://easystats.r-universe.dev/>).
#' @param packages Character vector, indicating which packages to be installed.
#'   By default, the option `"all"` will install all **easystats** packages.
#' @param force Logical, if `FALSE`, only those packages with a newer
#'   version number will be installed. Use `force=TRUE` to force
#'   installation of all packages, even if the version number for the locally
#'   installed packages is identical to the latest development-versions. Only
#'   applies when `source="development"`.
#' @param verbose Toggle messages.
#'
#' @return Invisible `NULL`.
#'
#' @examples
#' \dontrun{
#' # install latest development-version of easystats packages from
#' # the r-universe repository, but only those packages that have newer
#' # versions available
#' install.latest()
#'
#' # install all latest development-version of easystats packages from
#' # the r-universe repository, no matter whether local installations
#' # are up to date or not.
#' install.latest(force = TRUE)
#' }
#' @export
install_latest <- function(source = c("development", "cran"),
                           packages = "all",
                           force = FALSE,
                           verbose = TRUE) {
  source <- match.arg(source, c("development", "cran"))
  pkg <- .packages_on_cran()

  if (packages == "all") {
    packages <- pkg
  } else {
    packages <- intersect(packages, pkg)
  }

  if (source == "development") {
    repos <- "https://easystats.r-universe.dev"
  } else {
    repos <- getOption("repos")["CRAN"]
  }

  # only install newer versions?
  if (isFALSE(force) && source == "development") {
    insight::check_if_installed("jsonlite", reason = "to check for updates among development packages")
    if (isTRUE(verbose)) {
      insight::print_color("Looking for newer package versions...\n", "blue")
    }
    # get current CRAN and local versions
    easy_pkgs <- .easystats_version()
    # for development versions, overwrite CRAN version with r-universe version
    for (i in packages) {
      js <- jsonlite::fromJSON(paste0("https://easystats.r-universe.dev/packages/", i))
      easy_pkgs$cran[easy_pkgs$package == i] <- js$Version[1]
    }
    easy_pkgs$behind <- easy_pkgs$cran > easy_pkgs$local
    packages <- easy_pkgs$package[packages %in% easy_pkgs$package & easy_pkgs$behind]

    if (isTRUE(verbose) && !is.null(packages) && length(packages)) {
      colnames(easy_pkgs) <- c("Package", "Latest", "Installed", "behind")
      easy_pkgs <- easy_pkgs[easy_pkgs$behind, ]
      cat(insight::print_color("\nInstalling following packages:\n\n", "blue"))
      cat(insight::export_table(easy_pkgs[c("Package", "Latest", "Installed")]))
      cat("\n\n")
    }
  }

  if (is.null(packages) || !length(packages)) {
    if (isTRUE(verbose)) {
      insight::print_color("All easystats-packages are up to date!\n", "green")
    }
    return(invisible())
  }

  utils::install.packages(packages, repos = repos)
}
