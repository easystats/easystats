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

# Suppress R CMD check note
# Namespace in Imports field not imported from: PKG
#   All declared Imports should be used.
.ignore_unused_imports <- function() {
  bayestestR::describe_posterior()
  correlation::correlation()
  datawizard::data_tabulate()
  effectsize::effectsize()
  modelbased::estimate_expectation()
  parameters::model_parameters()
  performance::model_performance()
  report::report()
  see::flat_colors()
}
