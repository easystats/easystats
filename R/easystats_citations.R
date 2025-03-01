#' Reports citations for easystats publications
#'
#' This function reports the total number of Google Scholar citations
#' for `easystats` publications through the `scholar` package.
#' @return A data frame of 4 columns: title, journal, year, and cites.
#'
#' @examplesIf insight::check_if_installed("scholar", quietly = TRUE)
#' easystats_citations()
#'
#' @export
easystats_citations <- function() {
  insight::check_if_installed("scholar")
  dom <- "bg0BZ-QAAAAJ"
  pubs <- tryCatch(
    scholar::get_publications(dom),
    error = function(e) {
      message("Error fetching Google Scholar data: ", e$message)
      NULL
    }
  )
  easystats_pub <- pubs[grepl("L\u00fcdecke", pubs$author, fixed = TRUE), ]
  easystats_pub <- easystats_pub[easystats_pub$pubid != "hFOr9nPyWt4C", ]
  easystats_pub <- easystats_pub[c("title", "journal", "year", "cites")]
  rownames(easystats_pub) <- NULL
  rbind(easystats_pub, data.frame(
    title = "Total",
    journal = "Total",
    year = "Total",
    cites = sum(easystats_pub$cites),
    stringsAsFactors = FALSE
  ))
}
