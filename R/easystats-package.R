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
#
# # Wrapper interne pour easystats
# correlation <- function(..., ci = 0.95) {
#   # Appel à la fonction originale
#   x <- correlation::correlation(..., ci = ci)
#
#   # Si ci est explicitement FALSE, on supprime les colonnes CI pour l'affichage
#   if (identical(ci, FALSE)) {
#     cols_to_remove <- intersect(c("CI", "CI_low", "CI_high"), colnames(x))
#     if (length(cols_to_remove) > 0) {
#       x <- x[, !colnames(x) %in% cols_to_remove, drop = FALSE]
#     }
#   }
#   print('Hello')
#
#   return(x)
# }
#
#
#
# # Suppress R CMD check note
# # Namespace in Imports field not imported from: PKG
# #   All declared Imports should be used.
# .ignore_unused_imports <- function(ci = 0.95) {
#   bayestestR::describe_posterior()
#
#   # utilise notre version surchargée qui masque les IC si ci = FALSE
#   correlation_without_ci <- correlation(ci = FALSE)
#   correlation_without_ci  # juste pour marquer l’import utilisé
#
#   datawizard::data_tabulate()
#   effectsize::effectsize()
#   modelbased::estimate_expectation()
#   parameters::model_parameters()
#   performance::model_performance()
#   report::report()
#   see::flat_colors()
# }

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
  # Call to the original function
  x <- correlation::correlation(..., ci = ci)

  # Hide the CI columns if ci = FALSE
  if (identical(ci, FALSE)) {
    x <- x[, !colnames(x) %in% c("CI", "CI_low", "CI_high"), drop = FALSE]
  }
  return(x)
}


# Suppress R CMD check note
# Namespace in Imports field not imported from: PKG
#   All declared Imports should be used.
.ignore_unused_imports <- function(ci = 0.95) {
  # Using functions to avoid R CMD check warnings
  bayestestR::describe_posterior()

  # uses our overloaded version, which hides the ICs if ci = FALSE
  .correlation(ci = FALSE)

  datawizard::data_tabulate()
  effectsize::effectsize()
  modelbased::estimate_expectation()
  parameters::model_parameters()
  performance::model_performance()
  report::report()
  see::flat_colors()
}