#' Download all suggested packages
#'
#' In `easystats`, we have a 0-dependency policy, which makes our packages
#' fairly light and fast to install. However, we rely on many many (many)
#' packages for testing (at least all the packages for functions that we
#' support) and some specific features. These "soft dependencies" can be
#' downloaded at once using this function. This will allow you to fully utilize
#' 100\% of easystats' functionalities without errors.
#'
#' @param package If `NULL`, all suggested packages for all 'easystats'
#'   packages will be installed. If specific packages are specified, only
#'   suggested packages for those packages will be installed.
#'
#' @details
#'
#' To reduce the dependency load, 'easystats' packages by default will not
#' download all internally needed packages. It will ask the user to download
#' them only if they are needed. The current function can help install all
#' packages a given 'easystats' package might need. For example,
#' `install_suggested("see")`.
#'
#' @return
#'
#' Useful only for its side-effect of installing the needed packages.
#'
#' @examples
#' \dontrun{
#' install_suggested("easystats")
#' }
#'
#' @export
install_suggested <- function(package = "easystats") {
  suggested_packages <- .suggested_pkgs()

  if (is.null(package) || "easystats" %in% package) {
    package <- names(suggested_packages)
  }

  # unique suggested packages to download
  pkg_download <- unique(unlist(suggested_packages[package]))


  # install only the packages not yet installed
  installed_packages <- pkg_download %in% rownames(utils::installed.packages())

  if (any(!installed_packages)) {
    utils::install.packages(pkg_download[!installed_packages])
  } else {
    message("All of the suggested packages are already installed :)")
  }
}

# crawl suggestion fields

.find_suggested <- function(package) {
  insight::check_if_installed("xml2")

  url <- paste0("https://cloud.r-project.org/web/packages/", package, "/")
  html_page <- xml2::read_html(url)
  elements <- xml2::as_list(html_page)
  suggest_field <- elements$html$body$div$table[[4]][[3]]

  pkgs <- lapply(suggest_field, function(i) {
    if (is.list(i)) {
      i[[1]]
    } else {
      NA
    }
  })

  suggested_packages <- as.vector(unname(stats::na.omit(unlist(pkgs))))

  # remove Bioconductor packages
  setdiff(suggested_packages, "M3C")
}
