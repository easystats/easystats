#' Welcome to the easyverse
#'
#' @return A reassuring message.
#'
#' @examples
#' easystats_zen()
#'
#' @export
easystats_zen <- function() {
  print("Patience you must have my young padawan.")
}


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
