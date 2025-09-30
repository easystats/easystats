#' Reports download statistics for easystats packages
#'
#' This function reports download statistics for `easystats` packages from CRAN
#' through the `cranlogs` package.
#'
#' @param from Starting date for the download statistics. Defaults to
#' `"2019-02-26"`, which is when the first easystats package was released on CRAN.
#' @param sort_by Name of the column that should be used for sorting. Can be
#' `"package"`, `"total"`, or `"monthly"`. Use `NULL` for no sorting.
#' Defaults to `"total"` (total downloads).
#' @inheritParams insight::format_string
#'
#' @return A data frame with three columns: package, total downloads, and
#' average monthly downloads.
#'
#' @examplesIf insight::check_if_installed("cranlogs", quietly = TRUE)
#' \dontrun{
#' easystats_downloads()
#' }
#'
#' @export
easystats_downloads <- function(from = "2019-02-26", sort_by = "total", length = 30) {
  insight::check_if_installed("cranlogs")

  # Get easystats packages
  pkgs <- easystats_packages()

  # Get download data for all packages
  downloads_list <- lapply(pkgs, function(pkg) {
    tryCatch(
      cranlogs::cran_downloads(packages = pkg, from = from),
      error = function(e) {
        insight::format_warning(paste0("Could not fetch download data for ", pkg, ": ", e$message))
        NULL
      }
    )
  })

  # Remove NULL entries (failed downloads)
  downloads_list <- Filter(Negate(is.null), downloads_list)

  if (length(downloads_list) == 0) {
    insight::format_error("Could not fetch download data for any packages.")
  }

  # Combine all download data
  downloads_all <- do.call("rbind", downloads_list)

  # Helper function to calculate months between two dates
  .monnb <- function(d) {
    lt <- as.POSIXlt(as.Date(d, origin = "1900-01-01"))
    lt$year * 12 + lt$mon
  }

  .mondf <- function(d1, d2) {
    .monnb(d2) - .monnb(d1)
  }

  # Calculate total and monthly downloads per package
  stats <- lapply(split(downloads_all, downloads_all$package), function(d) {
    tmp <- d[d$count > 0, ]
    if (nrow(tmp) == 0) {
      return(data.frame(
        package = d$package[1],
        total = 0,
        monthly = 0,
        stringsAsFactors = FALSE
      ))
    }

    months_on_cran <- .mondf(tmp$date[1], tmp$date[nrow(tmp)])
    if (!length(months_on_cran) || months_on_cran < 1) months_on_cran <- 1

    data.frame(
      package = d$package[1],
      total = sum(tmp$count),
      monthly = round(sum(tmp$count) / months_on_cran),
      stringsAsFactors = FALSE
    )
  })

  out <- do.call(rbind, stats)
  rownames(out) <- NULL

  # Sort data
  if (!is.null(sort_by)) {
    sort_by <- insight::validate_argument(
      sort_by,
      c("package", "total", "monthly")
    )
    out <- out[order(out[[sort_by]], decreasing = TRUE), ]
  }

  # Shorten long strings
  if (!is.null(length)) {
    out$package <- insight::format_string(out$package, length)
  }

  # Add total row
  out <- rbind(
    out,
    data.frame(
      package = "Total",
      total = sum(out$total),
      monthly = sum(out$monthly),
      stringsAsFactors = FALSE
    )
  )

  # Capitalize column names
  colnames(out) <- tools::toTitleCase(colnames(out))
  class(out) <- c("easystats_downloads", "data.frame")

  out
}


# methods ------------------------------------------------------------------

#' @export
print.easystats_downloads <- function(x, ...) {
  # Format numeric columns with thousand separators
  x_formatted <- x
  x_formatted$Total <- format(x$Total, big.mark = ",", scientific = FALSE)
  x_formatted$Monthly <- format(x$Monthly, big.mark = ",", scientific = FALSE)

  cat(insight::export_table(x_formatted, ...))
}

#' @export
print_html.easystats_downloads <- function(x, ...) {
  # Format numeric columns with thousand separators
  x_formatted <- x
  x_formatted$Total <- format(x$Total, big.mark = ",", scientific = FALSE)
  x_formatted$Monthly <- format(x$Monthly, big.mark = ",", scientific = FALSE)

  insight::export_table(x_formatted, format = "html", ...)
}

#' @export
print_md.easystats_downloads <- function(x, ...) {
  # Format numeric columns with thousand separators
  x_formatted <- x
  x_formatted$Total <- format(x$Total, big.mark = ",", scientific = FALSE)
  x_formatted$Monthly <- format(x$Monthly, big.mark = ",", scientific = FALSE)

  insight::export_table(x_formatted, format = "markdown", ...)
}

#' @export
display.easystats_downloads <- function(object, format = "markdown", ...) {
  # Format numeric columns with thousand separators
  object_formatted <- object
  object_formatted$Total <- format(object$Total, big.mark = ",", scientific = FALSE)
  object_formatted$Monthly <- format(object$Monthly, big.mark = ",", scientific = FALSE)

  insight::export_table(object_formatted, format = format, ...)
}
