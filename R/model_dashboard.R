#' @title Generate a regression model summary from `easystats`
#'
#' @description
#'
#' A dashboard containing the following details for the entered regression model:
#'
#' - a tabular summary of parameter estimates
#' - a dot-and-whisker plot for parameter estimates
#' - a tabular summary of indices for the quality of model fit
#' - a collection of models for checking model assumptions
#' - a text report
#' - a model information table
#'
#' @return
#' An HTML dashboard.
#'
#' @param model A regression model object.
#' @param check_model_args A list of named arguments that are passed down to
#'   `performance::check_model()`. For further documentation and details
#'   about the arguments, see [this website](https://easystats.github.io/performance/reference/check_model.html).
#'   See also 'Examples'.
#' @param parameters_args A list of named arguments that are passed down to
#'   `parameters::model_parameters()`. For further documentation and details
#'   about the arguments, see [this website](https://easystats.github.io/parameters/reference/model_parameters.html).
#'   See also 'Examples'.
#' @param performance_args A list of named arguments that are passed down to
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
#' @section Troubleshooting:
#' For models with many observations, or for more complex models in general,
#' generating the model assumptions plot might become very slow. One reason
#' is that the underlying graphic engine becomes slow for plotting many data
#' points. In such cases, setting the argument `check_model_args = list(show_dots = FALSE)`
#' might help. Furthermore, look at other arguments of `?performance::check_model`,
#' which can be set using `check_model_args`, to increase performance (in
#' particular the `check`-argument can help, to skip some unnecessary checks).
#'
#' @examples
#' if (interactive()) {
#'   mod <- lm(wt ~ mpg, mtcars)
#'
#'   # with default options
#'   model_dashboard(mod)
#'
#'   # customizing 'parameters' output: standardize coefficients
#'   model_dashboard(mod, parameters_args = list(standardize = "refit"))
#'
#'   # customizing 'performance' output: only show selected performance metrics
#'   model_dashboard(mod, performance_args = list(metrics = c("AIC", "RMSE")))
#'
#'   # customizing output of model assumptions plot: don't show dots (faster plot)
#'   model_dashboard(mod, check_model_args = list(show_dots = FALSE))
#' }
#'
#' @export
model_dashboard <- function(model,
                            check_model_args = NULL,
                            parameters_args = NULL,
                            performance_args = NULL,
                            output_file = "easydashboard.html",
                            output_dir = getwd(),
                            rmd_dir = system.file("templates/easydashboard.Rmd", package = "easystats")) {
  insight::check_if_installed(c("DT", "flexdashboard"))

  model_name <- substitute(model)

  # render report into HTML
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
      params = list(
        model = model,
        model_name = model_name,
        check_model_args = check_model_args,
        parameters_args = parameters_args,
        performance_args = performance_args
      )
    )
  )

  # open dashboard
  report_path <- path.expand(file.path(output_dir, output_file))
  utils::browseURL(report_path)
}
