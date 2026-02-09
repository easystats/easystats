.easystats_deps <- function() {
  pkgs <- utils::available.packages()
  deps <- tools::package_dependencies(
    easystats_packages(),
    pkgs,
    recursive = FALSE
  )
  pkg_deps <- unique(sort(unlist(deps)))

  default_pkgs <- rownames(utils::installed.packages(priority = "base"))
  pkg_deps <- setdiff(pkg_deps, default_pkgs)

  cran_version <- lapply(pkgs[pkg_deps, "Version"], package_version)
  local_version <- lapply(pkg_deps, utils::packageVersion)

  behind <- unlist(Map(">", cran_version, local_version))

  data.frame(
    package = pkg_deps,
    cran = vapply(cran_version, as.character, FUN.VALUE = character(1L)),
    local = vapply(local_version, as.character, FUN.VALUE = character(1L)),
    behind = behind,
    stringsAsFactors = FALSE
  )
}


.easystats_version <- function() {
  # save timeout default. for this function, we want to reduce the timeout
  # for bad internet connections, see #466
  user_timeout <- getOption("timeout")
  # set back timeout on exit
  on.exit(options(timeout = user_timeout), add = TRUE)

  # set timout to a maximum of 10 seconds
  options(timeout = max(10, user_timeout))

  pkgs <- tryCatch(
    {
      utils::available.packages(
        contriburl = utils::contrib.url(
          "https://cloud.r-project.org",
          type = getOption("pkgType")
        )
      )
    },
    warning = function(w) {
      NULL
    },
    error = function(e) {
      NULL
    }
  )

  if (is.null(pkgs)) {
    easystats_pkgs <- easystats_packages()

    local_version <- lapply(easystats_pkgs, utils::packageVersion)

    out <- data.frame(
      package = easystats_pkgs,
      cran = NA,
      local = vapply(local_version, as.character, FUN.VALUE = character(1L)),
      behind = FALSE,
      stringsAsFactors = FALSE,
      row.names = NULL
    )
  } else {
    easystats_pkgs <- easystats_packages()

    cran_version <- lapply(pkgs[easystats_pkgs, "Version"], package_version)
    local_version <- lapply(easystats_pkgs, utils::packageVersion)

    behind <- unlist(Map(">", cran_version, local_version))

    out <- data.frame(
      package = easystats_pkgs,
      cran = vapply(cran_version, as.character, FUN.VALUE = character(1L)),
      local = vapply(local_version, as.character, FUN.VALUE = character(1L)),
      behind = behind,
      stringsAsFactors = FALSE,
      row.names = NULL
    )
  }

  out
}


#' List all packages in the easystats ecosystem
#'
#' @return A character vector
#' @export
#'
#' @examples
#' easystats_packages()
easystats_packages <- function() {
  # nocov start
  c(
    "bayestestR",
    "correlation",
    "datawizard",
    "easystats",
    "effectsize",
    "insight",
    "modelbased",
    "performance",
    "parameters",
    "report",
    "see"
  )
} # nocov end

.installed_packages <- function() {
  lib.loc <- .libPaths()
  all_pkgs <- list.files(lib.loc)
  all_pkgs[all_pkgs != "_cache"]
}
