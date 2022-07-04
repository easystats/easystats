#' @title Generate a regression model summary from `{easystats}`
#'
#' @description
#'
#' A dashboard containing the following details for the entered regression model:
#'
#' - tabular summary of parameter estimates
#' - a dot-and-whisker plot for parameter estimates
#' - tabular summary of indices for the quality of model fit
#' - a collection of models for checking model assumptions
#' - a text report
#'
#' @return
#' An HTML dashboard.
#'
#' @param model A regression model object.
#' @param parameters_arg A list of named arguments that are passed down to
#'   `parameters::model_parameters()`. For further documentation and details
#'   about the arguments, see [this website](https://easystats.github.io/parameters/reference/model_parameters.html).
#'   See also 'Examples'.
#' @param performance_arg A list of named arguments that are passed down to
#'   `performance::model_performance()`. For further documentation and details
#'   about the arguments, see [this website](https://easystats.github.io/performance/reference/model_performance.html).
#'   See also 'Examples'.
#' @param output_file A string specifying the file name in `rmarkdown::render()`.
#' Default is `"easydashboard.html"`.
#' @param output_dir A string specifying the path to the output directory for
#'   report in `rmarkdown::render()`. Default is to use the working directory.
#' @param rmd_dir A string specifying the path to the directory containing the
#'   RMarkdown template file. By default, package uses the template shipped with
#'   the package installation (`inst/templates/easydashboard.Rmd`).
#'
#' @examples
#' if (FALSE) {
#'   mod <- lm(wt ~ mpg, mtcars)
#'   model_dashboard(mod)
#'
#'   # standardize coefficients
#'   model_dashboard(mod, parameters_args = list(standardize = "refit"))
#'
#'   # only show selected performance metrics
#'   model_dashboard(mod, performance_args = list(metrics = c("AIC", "RMSE")))
#' }
#'
#' @export
model_dashboard <- function(model,
                            parameters_args = NULL,
                            performance_args = NULL,
                            output_file = "easydashboard.html",
                            output_dir = getwd(),
                            rmd_dir = system.file("templates/easydashboard.Rmd", package = "easystats")) {
  insight::check_if_installed("flexdashboard")

  # Render report into html
  suppressWarnings(
    rmarkdown::render(
      input = rmd_dir,
      output_format = flexdashboard::flex_dashboard(
        orientation = "columns",
        vertical_layout = "fill",
        source_code = "embed"
      ),
      output_file = output_file,
      output_dir = output_dir,
      intermediates_dir = output_dir,
      params = list(model = model, parameters_args = parameters_args, performance_args = performance_args)
    )
  )

  # open dashboard
  report_path <- path.expand(file.path(output_dir, output_file))
  utils::browseURL(report_path)
}
