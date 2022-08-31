.easystats_deps <- function() {
  pkgs <- utils::available.packages()
  deps <- tools::package_dependencies(.packages_on_cran(), pkgs, recursive = FALSE)
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
    easystats_pkgs <- .packages_on_github()
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
    easystats_pkgs <- .packages_on_github()
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

.cran_checks <- function(full = FALSE) {
  insight::check_if_installed("rvest")
  insight::check_if_installed("xml2")

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


.packages_on_cran <- function() {
  c(
    "bayestestR", "correlation", "datawizard", "effectsize", "insight",
    "modelbased", "performance", "parameters", "report", "see"
  )
}


.packages_on_github <- .packages_on_cran

.installed_packages <- function() {
  lib.loc <- .libPaths()
  all_pkgs <- list.files(lib.loc)
  all_pkgs[all_pkgs != "_cache"]
}
