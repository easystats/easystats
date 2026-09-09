#' List all news from development versions
#'
#' This function returns a list with all news from the latest development
#' packages' versions that are not yet on CRAN.
#'
#' @param packages String, name of the easystats-package, or `"all"` to include
#' all packages.
#'
#' @return A table (object of class *gt*), printed to the viewer pane.
#'
#' @export
easystats_whatsnew <- function(packages = "all") {
  easy_pkg <- easystats_packages()

  if (all(packages == "all")) {
    pkgs <- easy_pkg
  } else {
    pkgs <- packages
  }

  if (!all(pkgs %in% easy_pkg)) {
    insight::format_error(
      paste0(
        "Package(s)",
        datawizard::text_concatenate(setdiff(pkgs, easy_pkg)),
        "are no valid names for easystats-packages."
      )
    )
  }

  # no news for easystats package
  pkgs <- setdiff(pkgs, "easystats")

  out <- lapply(pkgs, function(pkg) {
    # read news file
    pkg_news <- system.file("NEWS.md", package = pkg)
    news_file <- readLines(pkg_news)

    # grep sections
    news_sections <- startsWith(news_file, paste("#", pkg))

    # latest news ends with sections 2
    news_file <- news_file[2:(which(news_sections)[2] - 1)]

    # strip empty lines
    news_file <- news_file[nzchar(news_file)]

    # merge multiple lines into one
    for (i in length(news_file):2) {
      if (startsWith(news_file[i], "  ")) {
        news_file[i - 1] <- paste(news_file[i - 1], trimws(news_file[i]))
        news_file[i] <- ""
      }
    }
    # strip empty lines
    news_file <- news_file[nzchar(news_file)]

    # group index
    groups <- vector("numeric")
    group_index <- 0
    removals <- vector("numeric")

    # split vector
    for (i in seq_along(news_file)) {
      headlines <- vapply(
        c("changes", "breaking changes", "bug fixes"),
        function(header) {
          grepl(header, tolower(news_file[i]), fixed = TRUE)
        },
        logical(1)
      )
      if (any(headlines)) {
        group_index <- group_index + 1
        removals <- c(removals, i)
      }
      groups <- c(groups, group_index)
    }

    # split by changes/bug fixes/...
    news_file <- split(news_file, groups)

    news_data <- do.call(
      rbind,
      lapply(news_file, function(i) {
        data.frame(
          Package = pkg,
          News = trimws(gsub("(^-|^\\*)", "", i[-1])),
          Section = toupper(trimws(gsub("##", "", i[1], fixed = TRUE)))
        )
      })
    )

    row.names(news_data) <- NULL
    news_data
  })

  names(out) <- pkgs

  insight::check_if_installed("gt")

  out_table <- insight::export_table(
    out,
    by = c("Package", "Section"),
    format = "html"
  )
  gt::cols_align(out_table, "left")
}
