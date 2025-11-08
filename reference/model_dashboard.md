# Generate a regression model summary from `easystats`

A dashboard containing the following details for the entered regression
model:

- tabular summary of parameter estimates

- dot-and-whisker plot for parameter estimates

- tabular summary of indices for the quality of model fit

- collection of models for checking model assumptions

- text report

- model information table

## Usage

``` r
model_dashboard(
  model,
  check_model_args = NULL,
  parameters_args = NULL,
  performance_args = NULL,
  output_file = "easydashboard.html",
  output_dir = getwd(),
  rmd_dir = system.file("templates/easydashboard.Rmd", package = "easystats"),
  quiet = FALSE,
  browse_html = interactive()
)
```

## Arguments

- model:

  A regression model object.

- check_model_args:

  A list of named arguments that are passed down to
  [`performance::check_model()`](https://easystats.github.io/performance/reference/check_model.html).
  For further documentation and details about the arguments, see [this
  website](https://easystats.github.io/performance/reference/check_model.html).
  See also 'Examples'.

- parameters_args:

  A list of named arguments that are passed down to
  [`parameters::model_parameters()`](https://easystats.github.io/parameters/reference/model_parameters.html).
  For further documentation and details about the arguments, see [this
  website](https://easystats.github.io/parameters/reference/model_parameters.html).
  See also 'Examples'.

- performance_args:

  A list of named arguments that are passed down to
  [`performance::model_performance()`](https://easystats.github.io/performance/reference/model_performance.html).
  For further documentation and details about the arguments, see [this
  website](https://easystats.github.io/performance/reference/model_performance.html).
  See also 'Examples'.

- output_file:

  A string specifying the file name in
  [`rmarkdown::render()`](https://pkgs.rstudio.com/rmarkdown/reference/render.html).
  Default is `"easydashboard.html"`.

- output_dir:

  A string specifying the path to the output directory for report in
  [`rmarkdown::render()`](https://pkgs.rstudio.com/rmarkdown/reference/render.html).
  Default is to use the working directory.

- rmd_dir:

  A string specifying the path to the directory containing the RMarkdown
  template file. By default, package uses the template shipped with the
  package installation (`inst/templates/easydashboard.Rmd`).

- quiet:

  An option to suppress printing during rendering from knitr, pandoc
  command line and others. To only suppress printing of the last "Output
  created: " message, you can set `rmarkdown.render.message` to `FALSE`

- browse_html:

  A logical deciding if the rendered HTML should be opened in the
  browser. Defaults to
  [`interactive()`](https://rdrr.io/r/base/interactive.html).

## Value

An HTML dashboard.

## Troubleshooting

For models with many observations, or for more complex models in
general, generating the model assumptions plot might become very slow.
One reason is that the underlying graphic engine becomes slow for
plotting many data points. In such cases, setting the argument
`check_model_args = list(show_dots = FALSE)` might help. Furthermore,
look at other arguments of
[`?performance::check_model`](https://easystats.github.io/performance/reference/check_model.html),
which can be set using `check_model_args`, to increase performance (in
particular the `check`-argument can help, to skip some unnecessary
checks).

## Examples

``` r
if (FALSE) { # interactive() && require("xml2", quietly = TRUE) && require("flexdashboard", quietly = TRUE)
# define a regression model
mod <- lm(wt ~ mpg, mtcars)

# with default options
model_dashboard(mod)

# customizing 'parameters' output: standardize coefficients
model_dashboard(mod, parameters_args = list(standardize = "refit"))

# customizing 'performance' output: only show selected performance metrics
model_dashboard(mod, performance_args = list(metrics = c("AIC", "RMSE")))

# customizing output of model assumptions plot: don't show dots (faster plot)
model_dashboard(mod, check_model_args = list(show_dots = FALSE))
}
```
