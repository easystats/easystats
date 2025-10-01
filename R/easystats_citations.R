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

  # scholar IDs
  dom <- "bg0BZ-QAAAAJ"
  dan <- "wC_6-9MAAAAJ"

  # publications from Dominique
  pubs_dom <- tryCatch(
    scholar::get_publications(dom),
    error = function(e) {
      insight::format_warning(
        "Could not fetch Google Scholar data: ",
        e$message
      )
      NULL
    }
  )

  # publications from Daniel, to add Phi, Fei, Fo, Fum
  pubs_dan <- tryCatch(
    scholar::get_publications(dan),
    error = function(e) {
      insight::format_warning(
        "Could not fetch Google Scholar data: ",
        e$message
      )
      NULL
    }
  )

  # Handle case where data could not be fetched
  if (is.null(pubs_dom) && is.null(pubs_dan)) {
    insight::format_alert(
      "Could not fetch any citation data from Google Scholar. Returning empty result."
    )
    out <- data.frame(
      title = "No data",
      journal = NA_character_,
      year = NA,
      cites = 0,
      stringsAsFactors = FALSE
    )
    colnames(out) <- tools::toTitleCase(colnames(out))
    class(out) <- c("easystats_cites", "data.frame")
    return(out)
  }

  # Process publications from Dominique
  if (is.null(pubs_dom)) {
    easystats_pub <- data.frame(
      title = character(0),
      journal = character(0),
      year = numeric(0),
      cites = numeric(0),
      stringsAsFactors = FALSE
    )
  } else {
    easystats_pub <- pubs_dom[
      grepl("L\u00fcdecke", pubs_dom$author, fixed = TRUE),
      ,
      drop = FALSE
    ]
    easystats_pub <- easystats_pub[c("title", "journal", "year", "cites")]
  }

  # Process publications from Daniel
  if (is.null(pubs_dan)) {
    easystats_pub2 <- data.frame(
      title = character(0),
      journal = character(0),
      year = numeric(0),
      cites = numeric(0),
      stringsAsFactors = FALSE
    )
  } else {
    easystats_pub2 <- pubs_dan[
      startsWith(pubs_dan$title, "Phi, Fei, Fo, Fum"),
      ,
      drop = FALSE
    ]
    easystats_pub2 <- easystats_pub2[c("title", "journal", "year", "cites")]
  }

  easystats_pub <- rbind(easystats_pub, easystats_pub2)

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
    easystats_pub$journal <- insight::format_string(
      easystats_pub$journal,
      length
    )
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
