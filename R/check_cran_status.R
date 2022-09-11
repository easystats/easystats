#' Show CRAN check status for easystats-packages
#'
#' @return `TRUE` if any of the easystats-packages show check-failures on CRAN,
#' `FALSE` otherwise.
#'
#' @note This functions is intended for maintainance-purposes, to timely detect
#' any check-issues on CRAN for easystats-packages.
#'
#' @examples
#' if (interactive()) {
#'   check_cran_status()
#' }
#' @export
check_cran_status <- function() {
  .cran_checks(full = TRUE)
}

#' @keywords internal
.cran_checks <- function(full = FALSE) {
  insight::check_if_installed("rvest")
  insight::check_if_installed("xml2")

  on_cran <- .packages_on_cran()
  error <- FALSE
  error_pkgs <- NULL

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
        insight::print_color(
          sprintf(
            "Warnings or errors in CRAN checks for package(s) %s.\n",
            paste0("'", error_pkgs, "'", collapse = ", ")
          ),
          "red"
        )
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
