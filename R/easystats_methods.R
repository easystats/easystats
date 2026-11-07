#' List all arguments used in easystats packages
#'
#' This function returns a list with all arguments that are used across all
#' easystats packages
#'
#' @param packages String, name of the easystats-package, or `"all"` to include
#' all packages.
#' @param argument String, name of an argument to search for. If provided, all
#' methods that contain this argument are returned. `argument` and `method` can
#' be combined.
#' @param method String, name of a method to search for. If provided, all
#' arguments for this method (for all classes that are supported) are returned.
#' `argument` and `method` can be combined.
#' @param flatten If `TRUE`, returns only one element and each argument only once.
#'
#' @return A named list with argument names used in the different packages.
#'
#' @examples
#' \dontrun{
#' easystats_arguments()
#'
#' easystats_arguments(argument = "dispersion")
#'
#' easystats_arguments(method = "get_parameters")
#'
#' out <- easystats_arguments(method = "describe_posterior", argument = "dispersion")
#' insight::export_table(out, format = "html")
#' }
#'
#' @export
easystats_arguments <- function(
  packages = "all",
  argument = NULL,
  method = NULL,
  flatten = FALSE
) {
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

  # clean () from method
  if (!is.null(method) && any(c("(", ")") %in% method)) {
    method <- insight::trim_ws(gsub("(\\(|\\))", "", method))
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

      argument_table <- sort(unique(unlist(
        insight::compact_list(lapply(fn, function(i) {
          formArgs <- tryCatch(
            {
              setdiff(
                methods::formalArgs(utils::getFromNamespace(i, pkg)),
                "..."
              )
            },
            error = function(e) NULL
          )
          # if no specific methods or arguments are requested, return element
          if (is.null(method) && is.null(argument)) {
            return(formArgs)
          }
          # if user searches for specific method, but no match, return NULL
          if (!is.null(method) && !startsWith(i, method)) {
            return(NULL)
          }

          # if user searches for specific arguments, but no match, return NULL
          if (!is.null(argument) && !argument %in% formArgs) {
            return(NULL)
          }

          # either return argument or method
          if (!is.null(method) && !is.null(argument)) {
            matchedArgs <- formArgs[match(argument, formArgs)]
            unmatchedArgs <- formArgs[-match(argument, formArgs)]
            return(paste0(
              i,
              ": ",
              matchedArgs,
              if (length(unmatchedArgs)) {
                paste0(" (and ", paste0(unmatchedArgs, collapse = ", "), ")")
              }
            ))
          } else if (!is.null(method)) {
            return(formArgs)
          } else {
            return(i)
          }
        })),
        use.names = FALSE
      )))

      # if we filter for both, we create a data frame, which is clearer to read
      if (!is.null(method) && !is.null(argument) && length(argument_table)) {
        pattern <- "^([^.]+)\\.([^:]+):\\s*(.*)$"
        final_table <- data.frame()
        for (element in 1:length(argument_table)) {
          matches <- regmatches(
            argument_table[element],
            regexec(pattern, argument_table[element])
          )[[1]]

          final_table <- do.call(
            rbind,
            list(
              final_table,
              data.frame(
                Function = matches[2],
                Class = matches[3],
                Arguments = matches[4]
              )
            )
          )
        }
        argument_table <- final_table
      }

      argument_table
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
