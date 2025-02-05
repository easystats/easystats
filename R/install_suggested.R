#' Download all suggested packages
#'
#' In `easystats`, we have a 0-dependency policy, which makes our packages
#' fairly light and fast to install. However, we rely on many many (many)
#' packages for testing (at least all the packages for functions that we
#' support) and some specific features. These "soft dependencies" can be
#' downloaded at once using this function. This will allow you to fully utilize
#' all of easystats' functionalities without errors.
#'
#' @param package If `NULL` or `"easystats"` (the default), all suggested
#'   packages for all 'easystats' packages will be installed. If specific
#'   packages are specified, only suggested packages for those packages will be
#'   installed.
#'
#' @details
#'
#' To reduce the dependency load, 'easystats' packages by default will not
#' download all internally needed packages. It will ask the user to download
#' them only if they are needed. The current function can help install all
#' packages a given 'easystats' package might need. For example,
#' `install_suggested("see")`. `show_suggested()` is a convenient helper
#' to show the current list of suggested packages for each 'easystats'
#' package.
#'
#' @return
#'
#' Useful only for its side-effect of installing the needed packages.
#'
#' @examples
#'
#' # download all suggested packages
#' if (FALSE) {
#'   install_suggested("easystats")
#' }
#'
#' # listing all reverse dependencies of easystats packages
#' show_reverse_dependencies()
#'
#' # listing all soft/weak dependencies of easystats packages
#' show_suggested()
#'
#' @export
install_suggested <- function(package = "easystats") {
  suggested_packages <- .suggested_pkgs()

  if (is.null(package) || "easystats" %in% package) {
    package <- names(suggested_packages)
  }

  # unique suggested packages to download
  pkg_download <- unique(unlist(suggested_packages[package]))

  # install only the packages not yet installed
  installed_packages <- pkg_download %in% .installed_packages()

  if (all(installed_packages)) {
    message("All of the suggested packages are already installed :)")
  } else if (insight::check_if_installed("pak", quietly = TRUE)) {
    pak::pkg_install(pkg_download[!installed_packages])
  } else {
    utils::install.packages(pkg_download[!installed_packages])
  }
}


#' @rdname install_suggested
#' @export
show_suggested <- function(package = "easystats") {
  suggested_packages <- .suggested_pkgs()

  if (is.null(package) || "easystats" %in% package) {
    package <- names(suggested_packages)
  }

  x <- suggested_packages[package]

  for (p in sort(names(x))) {
    if (length(x[[p]])) {
      sep <- strrep("-", nchar(p))
      insight::print_color(paste0(p, "\n", sep, "\n"), "red")
      cat(insight::format_message(toString(x[[p]])))
      cat("\n\n")
    }
  }

  invisible(x)
}


#' @rdname install_suggested
#' @export
show_reverse_dependencies <- function(package = "easystats") {
  revdep_packages <- .revdep_pkgs()

  if (is.null(package) || "easystats" %in% package) {
    package <- names(revdep_packages)
  }

  x <- revdep_packages[package]

  for (p in sort(names(x))) {
    if (length(x[[p]])) {
      sep <- strrep("-", nchar(p))
      insight::print_color(paste0(p, "\n", sep, "\n"), "red")
      cat(insight::format_message(toString(x[[p]])))
      cat("\n\n")
    }
  }

  invisible(x)
}

#' @keywords internal
.suggested_pkgs <- function() {
  insight::compact_list(list(
    insight     = .find_suggested("insight"),
    datawizard  = .find_suggested("datawizard"),
    performance = .find_suggested("performance"),
    parameters  = .find_suggested("parameters"),
    see         = .find_suggested("see"),
    effectsize  = .find_suggested("effectsize"),
    bayestestR  = .find_suggested("bayestestR"),
    correlation = .find_suggested("correlation"),
    report      = .find_suggested("report"),
    modelbased  = .find_suggested("modelbased")
  ))
}

#' @keywords internal
.revdep_pkgs <- function() {
  cran_packages <- tools::CRAN_package_db()

  insight::compact_list(list(
    insight     = .find_reverse_imports(cran_packages, "insight"),
    datawizard  = .find_reverse_imports(cran_packages, "datawizard"),
    performance = .find_reverse_imports(cran_packages, "performance"),
    parameters  = .find_reverse_imports(cran_packages, "parameters"),
    see         = .find_reverse_imports(cran_packages, "see"),
    effectsize  = .find_reverse_imports(cran_packages, "effectsize"),
    bayestestR  = .find_reverse_imports(cran_packages, "bayestestR"),
    correlation = .find_reverse_imports(cran_packages, "correlation"),
    report      = .find_reverse_imports(cran_packages, "report"),
    modelbased  = .find_reverse_imports(cran_packages, "modelbased")
  ))
}

# crawl suggestion fields

.find_suggested <- function(package) {
  # read suggests field from package description
  suggests <- tryCatch(suppressWarnings(utils::packageDescription(package)$Suggests),
    error = function(e) NULL
  )

  if (is.null(suggests)) {
    return(NULL)
  }

  suggested_packages <- insight::trim_ws(
    gsub("(\n|\\(.*\\))", "", unlist(strsplit(suggests, ",", fixed = TRUE)))
  )

  # remove Bioconductor packages
  setdiff(suggested_packages, "M3C")
}


# crawl reverse-dependency fields

.find_reverse_imports <- function(cran_packages, package) {
  rev_import_field <- cran_packages[cran_packages$Package == package, "Reverse imports"]
  # in case we have no reverse suggests, return NULL
  if (is.null(rev_import_field) || is.na(rev_import_field)) {
    return(NULL)
  }
  as.vector(unname(insight::trim_ws(unlist(strsplit(rev_import_field, ",", fixed = TRUE)))))
}
