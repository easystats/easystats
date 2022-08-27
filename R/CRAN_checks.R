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
#'   CRAN_checks()
#' }
#' @export
CRAN_checks <- function() {
  .cran_checks(full = TRUE)
}
