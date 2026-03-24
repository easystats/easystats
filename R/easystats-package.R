#' \code{easystats}
#'
#' @title easystats: Framework for Easy Statistical Modeling, Visualization, and Reporting
#'
#' @description
#'
#' A meta-package that installs and loads a set of packages from 'easystats'
#' ecosystem in a single step. This collection of packages provide a unifying
#' and consistent framework for statistical modeling, visualization, and
#' reporting. Additionally, it provides articles targeted at instructors for
#' teaching 'easystats', and a dashboard targeted at new R users for easily
#' conducting statistical analysis by accessing summary results, model fit
#' indices, and visualizations with minimal programming.
#'
#' @docType package
#' @aliases easystats easystats-package
#' @name easystats-package
#' @keywords internal
"_PACKAGE"


# Internal wrapper for easystats
.correlation <- function(..., ci = 0.95) {
  if (is.null(ci)) {
    ci <- FALSE
  }

  x <- correlation::correlation(..., ci = ci)

  if (identical(ci, FALSE)) {
    cols <- intersect(c("CI", "CI_low", "CI_high"), colnames(x))
    x <- x[, !colnames(x) %in% cols, drop = FALSE]
  }

  return(x)
}

#' Compute correlations with consistent CI handling
#'
#' Wrapper around [correlation::correlation()] that ensures
#' consistent handling of confidence intervals. In particular,
#' `ci = NULL` is treated as `ci = FALSE`, and CI columns are
#' removed from the output when not requested.
#'
#' @inheritParams correlation::correlation
#' @return A data frame of correlations
#' @export
correlation <- function(..., ci = 0.95) {
  .correlation(..., ci = ci)
}


# Suppress R CMD check note
# Namespace in Imports field not imported from: PKG
#   All declared Imports should be used.
.ignore_unused_imports <- function() {
  bayestestR::describe_posterior()
  correlation(mtcars, ci = FALSE)

  datawizard::data_tabulate()
  effectsize::effectsize()
  modelbased::estimate_expectation()
  parameters::model_parameters()
  performance::model_performance()
  report::report()
  see::flat_colors()
}