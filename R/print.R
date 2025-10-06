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
print.easystats_downloads <- function(x, ...) {
  cat(insight::export_table(x, big_mark = ",", ...))
}

#' @export
print_html.easystats_downloads <- function(x, ...) {
  insight::export_table(x, big_mark = ",", format = "html", ...)
}

#' @export
print_md.easystats_downloads <- function(x, ...) {
  insight::export_table(x, big_mark = ",", format = "markdown", ...)
}

#' @export
display.easystats_downloads <- function(object, format = "markdown", ...) {
  format <- insight::validate_argument(format, c("markdown", "html", "md", "tt"))
  insight::export_table(object, big_mark = ",", format = format, ...)
}

#' @export
print.easystats_cites <- print.easystats_downloads

#' @export
print_html.easystats_cites <- print_html.easystats_downloads

#' @export
print_md.easystats_cites <- print_md.easystats_downloads

#' @export
display.easystats_cites <- display.easystats_downloads
