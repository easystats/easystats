#' Reports citations for easystats publications
#'
#' This function reports the total number of Google Scholar citations for
#' `easystats` publications through the `scholar` package.
#'
#' @param sort_by Name of the column that should be used for sorting. Can be
#' `"title"`, `"journal"`, `"year"`, or `"cites"`. Use `NULL` for no sorting and
#' to return data as retrieved by Google scholar.
#' @inheritParams insight::format_string
#'
#' @return A data frame of four columns: title, journal, year, and cites.
#'
#' @examplesIf insight::check_if_installed("scholar", quietly = TRUE)
#' \dontrun{
#' easystats_citations()
#' }
#'
#' @export
easystats_citations <- function(sort_by = "year", length = 30) {
  insight::check_if_installed("scholar")
  dom <- "bg0BZ-QAAAAJ"

  pubs <- tryCatch(
    scholar::get_publications(dom),
    error = function(e) {
      insight::format_error("Error fetching Google Scholar data: ", e$message)
    }
  )

  easystats_pub <- pubs[grepl("L\u00fcdecke", pubs$author, fixed = TRUE), ]
  easystats_pub <- easystats_pub[easystats_pub$pubid != "hFOr9nPyWt4C", ]
  easystats_pub <- easystats_pub[c("title", "journal", "year", "cites")]

  rownames(easystats_pub) <- NULL

  # sort data
  if (!is.null(sort_by)) {
    sort_by <- insight::validate_argument(
      sort_by,
      c("title", "journal", "year", "cites")
    )
    easystats_pub <- easystats_pub[
      order(easystats_pub[[sort_by]], decreasing = TRUE),
    ]
  }

  # shorten long strings
  if (!is.null(length)) {
    easystats_pub$title <- insight::format_string(easystats_pub$title, length)
    easystats_pub$journal <- insight::format_string(easystats_pub$journal, length)
  }

  # create Data, including Total Row
  out <- rbind(
    easystats_pub,
    data.frame(
      title = "Total",
      journal = NA_character_,
      year = NA,
      cites = sum(easystats_pub$cites),
      stringsAsFactors = FALSE
    )
  )

  # capitalize column names
  colnames(out) <- tools::toTitleCase(colnames(out))
  class(out) <- c("easystats_cites", "data.frame")

  out
}

# reexports ----------------------------------------------------------------

#' @importFrom insight print_html
#' @export
insight::print_html


#' @importFrom insight print_md
#' @export
insight::print_md


#' @importFrom insight display
#' @export
insight::display


# methods ------------------------------------------------------------------

#' @export
print.easystats_cites <- function(x, ...) {
  cat(insight::export_table(x, ...))
}

#' @export
print_html.easystats_cites <- function(x, ...) {
  insight::export_table(x, format = "html", ...)
}

#' @export
print_md.easystats_cites <- function(x, ...) {
  insight::export_table(x, format = "markdown", ...)
}

#' @export
display.easystats_cites <- function(object, format = "markdown", ...) {
  insight::export_table(object, format = format, ...)
}
