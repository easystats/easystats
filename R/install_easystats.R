#' Welcome to the easyverse
#' @import insight performance bayestestR parameters correlation report estimate see
#' @export
easystats_zen <- function(){
  print("Patience you must have my young padawan.")
}


#' Install the easystats suite from github
#' @import insight performance bayestestR parameters correlation report estimate see
#' @importFrom devtools install_github
#' @export
install_easystats_latest <- function(){
  devtools::install_github(c("easystats/insight",
                             "easystats/bayestestR",
                             "easystats/performance",
                             "easystats/parameters",
                             "easystats/correlation",
                             "easystats/estimate",
                             "easystats/see",
                             "easystats/report"))
}

#' Install the dev branches of easystats from github
#' @import insight performance bayestestR parameters correlation report estimate see
#' @importFrom devtools install_github
#' @export
install_easystats_dev <- function(){
  devtools::install_github(c("easystats/insight",
                             "easystats/bayestestR",
                             "easystats/performance",
                             "easystats/parameters",
                             "easystats/correlation",
                             "easystats/estimate",
                             "easystats/see",
                             "easystats/report"), ref = "dev")
}


#' @importFrom utils menu install.packages
#' @export
easystats_update <- function() {
  deps <- .easystats_deps()
  behind <- deps[deps$behind, ]

  if (nrow(behind) == 0) return(invisible())

  message("The following packages are out of date:")
  message(paste0(" * ", format(behind$package), " (", behind$local, " -> ", behind$cran, ")"), collapse = "\n")

  message("Update now?")
  do_it <- utils::menu(c("Yes", "No")) == 1

  if (!do_it) {
    return(invisible())
  }

  utils::install.packages(
    behind$package,
    quiet = TRUE,
    dependencies = FALSE
  )

  invisible()
}


#' @importFrom utils available.packages packageVersion
#' @importFrom tools package_dependencies
.easystats_deps <- function() {
  pkgs <- utils::available.packages()

  deps <-
    tools::package_dependencies(
      c(
        "insight",
        "bayestestR",
        "performance",
        "parameters",
        "see",
        "estimate",
        "correlation",
        "report"
      ),
      pkgs,
      recursive = F
    )

  pkg_deps <- unique(sort(unlist(deps)))

  base_pkgs <- c(
    "base", "compiler", "datasets", "graphics", "grDevices", "grid",
    "methods", "parallel", "splines", "stats", "stats4", "tools", "tcltk",
    "utils"
  )
  pkg_deps <- setdiff(pkg_deps, base_pkgs)

  cran_version <- lapply(pkgs[pkg_deps, "Version"], package_version)
  local_version <- lapply(pkg_deps, utils::packageVersion)

  behind <- mapply('>', cran_version, local_version)

  data.frame(
    package = pkg_deps,
    cran = sapply(cran_version, as.character),
    local = sapply(local_version, as.character),
    behind = behind,
    stringsAsFactors = FALSE
  )
}



#' @importFrom utils available.packages packageVersion
#' @importFrom tools package_dependencies
.easystats_version <- function() {
  pkgs <- utils::available.packages(contriburl = contrib.url("https://cran.r-project.org", type = getOption("pkgType")))
  easystats_pkgs <- c("insight", "bayestestR", "performance", "parameters", "see", "correlation", "estimate", "report")
  easystats_on_cran <- intersect(easystats_pkgs, rownames(pkgs))
  easystats_not_on_cran <- setdiff(easystats_pkgs, easystats_on_cran)

  cran_version <- lapply(pkgs[easystats_on_cran, "Version"], package_version)
  local_version <- lapply(easystats_on_cran, utils::packageVersion)
  local_version_dev <- lapply(easystats_not_on_cran, utils::packageVersion)

  behind <- mapply('>', cran_version, local_version)

  rbind(
    data.frame(
      package = easystats_on_cran,
      cran = sapply(cran_version, as.character),
      local = sapply(local_version, as.character),
      behind = behind,
      stringsAsFactors = FALSE,
      row.names = NULL
    ),
    data.frame(
      package = easystats_not_on_cran,
      cran = NA,
      local = sapply(local_version_dev, as.character),
      behind = FALSE,
      stringsAsFactors = FALSE,
      row.names = NULL
    )
  )
}