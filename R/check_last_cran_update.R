#' Show weeks since last package update on CRAN
#'
#' Green indicates that enough time since last submission has passed and it's ok
#' to submit an update, yellow means it's ok, but beware it's not too often, and
#' red means that you should probably not yet submit an update.
#'
#' @note This functions is intended for development purposes only, to ensure
#' that package updates are not submitted to CRAN within too short intervals.
#'
#' @return Invisible `NULL`.
#'
#' @examples
#' check_last_cran_update()
#' @export
check_last_cran_update <- function() {
  insight::check_if_installed("rvest")
  insight::check_if_installed("xml2")

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

        # CRAN policy (https://cran.r-project.org/web/packages/policies.html):
        #
        # "Submitting updates should be done responsibly and with respect for the
        # volunteers' time. Once a package is established (which may take
        # several rounds), 'no more than every 1–2 months' seems appropriate."
        if (weeks_on_cran <= 4) {
          col <- "red"
        } else if (weeks_on_cran <= 8) {
          col <- "yellow"
        } else {
          col <- "green"
        }
        insight::print_color(
          sprintf("%.1f weeks (%s)\n", weeks_on_cran, as.character(as.POSIXct(date))),
          col
        )
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
