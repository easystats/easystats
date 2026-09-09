#' List all arguments used in easystats packages
#'
#' This function returns a list with all arguments that are used across all
#' easystats packages
#'
#' @param packages String, name of the easystats-package, or `"all"` to include
#' all packages.
#' @param flatten If `TRUE`, returns only one element and each argument only once.
#'
#' @return A named list with argument names used in the different packages.
#'
#' @export
easystats_arguments <- function(packages = "all", flatten = FALSE) {
  easy_pkg <- easystats_packages()

  if (all(packages == "all")) {
    pkgs <- easystats_packages()
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

  out <- lapply(pkgs, function(pkg) {
    do.call(library, list(eval(pkg)))
    fns <- ls(paste0("package:", pkg))
    rds_filepath <- file.path(find.package(pkg), "NAMESPACE")

    all_fns <- as.data.frame(utils::read.table(rds_filepath, fill = TRUE))

    if (!is.null(all_fns) && is.data.frame(all_fns)) {
      names(all_fns) <- "func"
      all_fns <- all_fns[startsWith(all_fns$func, "S3method("), , drop = FALSE]
      fn <- gsub("S3method\\((.*)\\)", "\\1", all_fns$func)
      fn <- gsub(",", ".", fn, fixed = TRUE)

      sort(unique(unlist(
        insight::compact_list(lapply(fn, function(i) {
          form_args <- tryCatch(
            {
              setdiff(
                methods::formalArgs(utils::getFromNamespace(i, pkg)),
                "..."
              )
            },
            error = function(e) NULL
          )
        })),
        use.names = FALSE
      )))
    }
  })

  names(out) <- pkgs
  out <- insight::compact_list(out)

  if (flatten) {
    sort(unique(unlist(out, use.names = FALSE)))
  } else {
    out
  }
}
