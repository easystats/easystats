#' Welcome to the easyverse
#' @export
easystats_zen <- function() {
  print("Patience you must have my young padawan.")
}

#' Show CRAN check status for easystats-packages
#' @export
CRAN_checks <- function() {
  .cran_checks(full = TRUE)
}


#' Install the easystats suite from github
#'
#' This function can be used to install all the easystats package from github, either from the master branch (the stable one) with \code{install_easystats_latest()} or from the dev branch \code{install_easystats_dev()}.
#'
#' @importFrom remotes install_github
#' @export
install_easystats_latest <- function() {
  remotes::install_github(c(
    "easystats/insight",
    "easystats/bayestestR",
    "easystats/performance",
    "easystats/parameters",
    "easystats/effectsize",
    "easystats/correlation",
    "easystats/modelbased",
    "easystats/see",
    "easystats/report"
  ),
  upgrade = "never"
  )
}

#' @rdname install_easystats_latest
#' @export
easystats_install_latest <- install_easystats_latest

#' @rdname install_easystats_latest
#' @importFrom remotes install_github
#' @export
install_easystats_dev <- function() {
  remotes::install_github(c(
    "easystats/insight",
    "easystats/bayestestR",
    "easystats/performance",
    "easystats/parameters",
    "easystats/effectsize",
    "easystats/correlation",
    "easystats/modelbased",
    "easystats/see",
    "easystats/report"
  ),
  ref = "dev",
  upgrade = "never"
  )
}

#' @rdname install_easystats_latest
#' @export
easystats_install_dev <- install_easystats_dev




#' Update easystats-packages and its dependencies from CRAN, if necessary.
#'
#' @param which String, indicates whether easystats-packages (\code{which = "core"}), dependencies (\code{which = "deps"}) or both (\code{which = "all"}) should be checked for available updates.
#' @importFrom utils menu install.packages
#' @export
easystats_update <- function(which = c("all", "core", "deps")) {
  which <- match.arg(which)

  if (which %in% c("all", "core")) {
    core <- .easystats_version()
    behind <- core[core$behind, ]

    if (nrow(behind) == 0) {
      insight::print_color("All easystats-packages are up to date!\n", "green")
      return(invisible())
    }

    message("The following packages are out of date:")
    message(paste0(" * ", format(behind$package), " (", behind$local, " -> ", behind$cran, ")"), collapse = "\n")

    message("Update now?")
    do_it <- utils::menu(c("Yes", "No")) == 1

    if (!do_it) {
      return(invisible())
    }

    # detach packages before installing
    lapply(behind$package, unloadNamespace)

    utils::install.packages(
      behind$package,
      quiet = TRUE,
      dependencies = FALSE
    )
  }

  if (which %in% c("all", "deps")) {
    deps <- .easystats_deps()
    behind <- deps[deps$behind, ]

    if (nrow(behind) == 0) {
      insight::print_color("All easystats-dependencies are up to date!\n", "green")
      return(invisible())
    }

    message("The following packages are out of date:")
    message(paste0(" * ", format(behind$package), " (", behind$local, " -> ", behind$cran, ")"), collapse = "\n")

    message("Update now?")
    do_it <- utils::menu(c("Yes", "No")) == 1

    if (!do_it) {
      return(invisible())
    }

    # detach packages before installing
    lapply(behind$package, unloadNamespace)

    utils::install.packages(
      behind$package,
      quiet = TRUE,
      dependencies = FALSE
    )
  }

  invisible()
}


#' @importFrom utils available.packages packageVersion
#' @importFrom tools package_dependencies
.easystats_deps <- function() {
  pkgs <- utils::available.packages()

  deps <-
    tools::package_dependencies(
      c(
        "insight",
        "bayestestR",
        "performance",
        "parameters",
        "see",
        "effectsize",
        "modelbased",
        "correlation",
        "report"
      ),
      pkgs,
      recursive = FALSE
    )

  pkg_deps <- unique(sort(unlist(deps)))

  base_pkgs <- c(
    "base", "compiler", "datasets", "graphics", "grDevices", "grid",
    "methods", "parallel", "splines", "stats", "stats4", "tools", "tcltk",
    "utils"
  )
  pkg_deps <- setdiff(pkg_deps, base_pkgs)

  cran_version <- lapply(pkgs[pkg_deps, "Version"], package_version)
  local_version <- lapply(pkg_deps, utils::packageVersion)

  behind <- mapply(">", cran_version, local_version)

  data.frame(
    package = pkg_deps,
    cran = sapply(cran_version, as.character),
    local = sapply(local_version, as.character),
    behind = behind,
    stringsAsFactors = FALSE
  )
}



#' @importFrom utils available.packages packageVersion contrib.url
#' @importFrom tools package_dependencies
.easystats_version <- function() {
  pkgs <- tryCatch(
    {
      utils::available.packages(contriburl = utils::contrib.url("https://cloud.r-project.org", type = getOption("pkgType")))
    },
    warning = function(w) {
      NULL
    },
    error = function(e) {
      NULL
    }
  )

  if (!is.null(pkgs)) {
    easystats_pkgs <- c("insight", "bayestestR", "performance", "parameters", "see", "effectsize", "correlation", "modelbased", "report")
    easystats_on_cran <- intersect(easystats_pkgs, rownames(pkgs))
    easystats_not_on_cran <- setdiff(easystats_pkgs, easystats_on_cran)

    cran_version <- lapply(pkgs[easystats_on_cran, "Version"], package_version)
    local_version <- lapply(easystats_on_cran, utils::packageVersion)

    behind <- mapply(">", cran_version, local_version)

    out <- data.frame(
      package = easystats_on_cran,
      cran = sapply(cran_version, as.character),
      local = sapply(local_version, as.character),
      behind = behind,
      stringsAsFactors = FALSE,
      row.names = NULL
    )

    .add_easystats_dev_pkgs(out, easystats_not_on_cran)
  } else {
    easystats_pkgs <- c("insight", "bayestestR", "performance", "parameters", "see", "effectsize", "correlation", "modelbased", "report")
    easystats_on_cran <- .packages_on_cran()
    easystats_not_on_cran <- setdiff(easystats_pkgs, easystats_on_cran)

    local_version <- lapply(easystats_on_cran, utils::packageVersion)

    out <- data.frame(
      package = easystats_on_cran,
      cran = NA,
      local = sapply(local_version, as.character),
      behind = FALSE,
      stringsAsFactors = FALSE,
      row.names = NULL
    )

    .add_easystats_dev_pkgs(out, easystats_not_on_cran)
  }
}


.add_easystats_dev_pkgs <- function(out, easystats_not_on_cran) {
  if (length(easystats_not_on_cran) > 0) {

    # check if any dev-version is actually installed
    easystats_not_on_cran <- sapply(
      easystats_not_on_cran,
      function(i) {
        p <- try(find.package(i, verbose = FALSE, quiet = TRUE))
        if (!inherits(p, "try-error") && length(p) > 0) {
          i
        } else {
          ""
        }
      }
    )

    # remove empty
    easystats_not_on_cran <- easystats_not_on_cran[nchar(easystats_not_on_cran) > 0]

    # only check for dev-versions when these are actually installed...
    if (length(easystats_not_on_cran) > 0) {
      local_version_dev <- lapply(easystats_not_on_cran, utils::packageVersion)

      out <- rbind(
        out,
        data.frame(
          package = easystats_not_on_cran,
          cran = NA,
          local = sapply(local_version_dev, as.character),
          behind = FALSE,
          stringsAsFactors = FALSE,
          row.names = NULL
        )
      )
    }
  }

  out
}


#' @importFrom rvest html_table
#' @importFrom xml2 read_html
.cran_checks <- function(full = FALSE) {
  on_cran <- .packages_on_cran()
  error <- FALSE
  error_pkgs <- c()

  tryCatch(
    {
      for (i in on_cran) {
        url <- sprintf("https://cloud.r-project.org/web/checks/check_results_%s.html", i)
        html_page <- xml2::read_html(url)
        html_table <- rvest::html_table(html_page)
        check_status <- html_table[[1]]$Status

        if (isTRUE(full)) {
          all_ok <- TRUE
          max_len <- max(nchar(on_cran))
          i <- format(i, width = max_len)
          cat(sprintf("%s ", i))

          if (any("error" %in% tolower(check_status))) {
            n <- sum("error" == tolower(check_status))
            if (n == 1) {
              insight::print_color("1 Error", "red")
            } else {
              insight::print_color(sprintf("%g Errors", n), "red")
            }
            error <- TRUE
            all_ok <- FALSE
          }
          if (any(c("warning", "warn") %in% tolower(check_status))) {
            if (!all_ok) cat(", ")
            n <- sum("warning" == tolower(check_status)) + sum("warn" == tolower(check_status))
            if (n == 1) {
              insight::print_color("1 Warning", "red")
            } else {
              insight::print_color(sprintf("%g Warnings", n), "red")
            }
            error <- TRUE
            all_ok <- FALSE
          }
          if (any("note" %in% tolower(check_status))) {
            if (!all_ok) cat(", ")
            n <- sum("note" == tolower(check_status))
            if (n == 1) {
              insight::print_color("1 Note", "blue")
            } else {
              insight::print_color(sprintf("%g Notes", n), "blue")
            }
            all_ok <- FALSE
          }
          if (isTRUE(all_ok)) {
            insight::print_color("Ok", "green")
          }
          cat("\n")
        } else {
          if (any(c("warn", "warning", "error") %in% tolower(check_status))) {
            error_pkgs <- c(error_pkgs, i)
            error <- TRUE
          }
        }
      }

      if (error && !full) {
        insight::print_color(sprintf("Warnings or errors in CRAN checks for package(s) %s.\n", paste0("'", error_pkgs, "'", collapse = ", ")), "red")
      }

      invisible(error)
    },
    warning = function(w) {
      invisible(FALSE)
    },
    error = function(e) {
      invisible(FALSE)
    }
  )
}


#' Show weeks since last package update on CRAN
#'
#' Green indicates that enough time since last submission has passed and it's ok to submit an update, yellow means it's ok, but beware it's not too often, and red means that you should probably not yet submit an update.
#'
#' @export
on_CRAN <- function() {
  on_cran <- .packages_on_cran()
  tryCatch(
    {
      for (i in on_cran) {
        url <- sprintf("https://cloud.r-project.org/web/packages/%s/index.html", i)
        html_page <- xml2::read_html(url)
        html_table <- rvest::html_table(html_page)
        published <- grepl("^Publishe", html_table[[1]]$X1)
        date <- html_table[[1]]$X2[published]
        weeks_on_cran <- as.vector(difftime(as.POSIXct(Sys.Date()), as.POSIXct(date), units = "weeks"))
        max_len <- max(nchar(on_cran))
        i <- format(i, width = max_len)
        cat(sprintf("%s ", i))
        if (weeks_on_cran <= 4) {
          col <- "red"
        } else if (weeks_on_cran <= 8) {
          col <- "yellow"
        } else {
          col <- "green"
        }
        insight::print_color(sprintf("%.1f weeks\n", weeks_on_cran), col)
      }
    },
    warning = function(w) {
      invisible(NULL)
    },
    error = function(e) {
      invisible(NULL)
    }
  )

  invisible(NULL)
}



.packages_on_cran <- function() {
  c(
    "insight", "bayestestR", "performance", "parameters", "effectsize",
    "modelbased", "correlation", "see", "report"
  )
}
