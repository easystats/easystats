
# easystats

<img src='https://github.com/easystats/insight/raw/master/man/figures/logo.png' align="left" height="120" />
<img src='https://github.com/easystats/bayestestR/raw/master/man/figures/logo.png' align="left" height="120" />
<img src='https://github.com/easystats/parameters/raw/master/man/figures/logo.png' align="left" height="120" />
<img src='https://github.com/easystats/performance/raw/master/man/figures/logo.png' align="left" height="120" />
<img src='https://github.com/easystats/estimate/raw/master/man/figures/logo.png' align="left" height="120" />
<img src='https://github.com/easystats/correlation/raw/master/man/figures/logo.png' align="left" height="120" />
<img src='https://github.com/easystats/report/raw/master/man/figures/logo.png' align="left" height="120" />

<!-- THE UGLY OUTPUT IS ANNOYING -->

The aim of **easystats** is to provide a unifying and consistent
framework to tame, discipline and harness the scary R statistics and
their pesky models.

# Installation

The wole `easystats` suite can be installed *at once* with the
following:

``` r
install.packages("devtools")
devtools::install_github("easystats/easystats")
```

``` r
library("easystats")
```

# List of functions

  - [**`%>%`**](https://easystats.github.io/report/reference/%%3E%.html)
    *(report)*
  - [**`as.numeric_ifnumeric`**](https://easystats.github.io/estimate/reference/as.numeric_ifnumeric.html)
    *(estimate)*
  - [**`as.report`**](https://easystats.github.io/report/reference/as.report.html)
    *(report)*
  - [**`ci_wald`**](https://easystats.github.io/parameters/reference/ci_wald.html)
    *(parameters)*
  - [**`ci`**](https://easystats.github.io/bayestestR/reference/ci.html)
    *(bayestestR)*
  - [**`cite_packages`**](https://easystats.github.io/report/reference/cite_packages.html)
    *(report)*
  - [**`clean_names`**](https://easystats.github.io/insight/reference/clean_names.html)
    *(insight)*
  - [**`cor_test`**](https://easystats.github.io/correlation/reference/cor_test.html)
    *(correlation)*
  - [**`correlation`**](https://easystats.github.io/correlation/reference/correlation.html)
    *(correlation)*
  - [**`cronbachs_alpha`**](https://easystats.github.io/performance/reference/cronbachs_alpha.html)
    *(performance)*
  - [**`data_grid`**](https://easystats.github.io/estimate/reference/data_grid.html)
    *(estimate)*
  - [**`density_at`**](https://easystats.github.io/bayestestR/reference/density_at.html)
    *(bayestestR)*
  - [**`describe_posterior`**](https://easystats.github.io/parameters/reference/describe_posterior.html)
    *(parameters)*
  - [**`dof_kenward`**](https://easystats.github.io/parameters/reference/dof_kenward.html)
    *(parameters)*
  - [**`download_model`**](https://easystats.github.io/insight/reference/download_model.html)
    *(insight)*
  - [**`equivalence_test`**](https://easystats.github.io/bayestestR/reference/equivalence_test.html)
    *(bayestestR)*
  - [**`error_rate`**](https://easystats.github.io/performance/reference/error_rate.html)
    *(performance)*
  - [**`estimate_contrasts`**](https://easystats.github.io/estimate/reference/estimate_contrasts.html)
    *(estimate)*
  - [**`estimate_fit`**](https://easystats.github.io/estimate/reference/estimate_fit.html)
    *(estimate)*
  - [**`estimate_means`**](https://easystats.github.io/estimate/reference/estimate_means.html)
    *(estimate)*
  - [**`estimate_response`**](https://easystats.github.io/estimate/reference/estimate_response.html)
    *(estimate)*
  - [**`estimate_slopes`**](https://easystats.github.io/estimate/reference/estimate_slopes.html)
    *(estimate)*
  - [**`estimate_smooth`**](https://easystats.github.io/estimate/reference/estimate_smooth.html)
    *(estimate)*
  - [**`find_algorithm`**](https://easystats.github.io/insight/reference/find_algorithm.html)
    *(insight)*
  - [**`find_distribution`**](https://easystats.github.io/parameters/reference/find_distribution.html)
    *(parameters)*
  - [**`find_formula`**](https://easystats.github.io/insight/reference/find_formula.html)
    *(insight)*
  - [**`find_parameters`**](https://easystats.github.io/insight/reference/find_parameters.html)
    *(insight)*
  - [**`find_predictors`**](https://easystats.github.io/insight/reference/find_predictors.html)
    *(insight)*
  - [**`find_random_slopes`**](https://easystats.github.io/insight/reference/find_random_slopes.html)
    *(insight)*
  - [**`find_random`**](https://easystats.github.io/insight/reference/find_random.html)
    *(insight)*
  - [**`find_response`**](https://easystats.github.io/insight/reference/find_response.html)
    *(insight)*
  - [**`find_terms`**](https://easystats.github.io/insight/reference/find_terms.html)
    *(insight)*
  - [**`find_variables`**](https://easystats.github.io/insight/reference/find_variables.html)
    *(insight)*
  - [**`format_algorithm`**](https://easystats.github.io/report/reference/format_algorithm.html)
    *(report)*
  - [**`format_bf`**](https://easystats.github.io/report/reference/format_bf.html)
    *(report)*
  - [**`format_ci`**](https://easystats.github.io/report/reference/format_ci.html)
    *(report)*
  - [**`format_model`**](https://easystats.github.io/report/reference/format_model.html)
    *(report)*
  - [**`format_p`**](https://easystats.github.io/report/reference/format_p.html)
    *(report)*
  - [**`format_pd`**](https://easystats.github.io/report/reference/format_pd.html)
    *(report)*
  - [**`format_rope`**](https://easystats.github.io/report/reference/format_rope.html)
    *(report)*
  - [**`format_text_collapse`**](https://easystats.github.io/report/reference/format_text_collapse.html)
    *(report)*
  - [**`format_text_wrap`**](https://easystats.github.io/report/reference/format_text_wrap.html)
    *(report)*
  - [**`format_value_unless_integers`**](https://easystats.github.io/report/reference/format_value_unless_integers.html)
    *(report)*
  - [**`format_value`**](https://easystats.github.io/report/reference/format_value.html)
    *(report)*
  - [**`generalized_inverse`**](https://easystats.github.io/correlation/reference/generalized_inverse.html)
    *(correlation)*
  - [**`get_correlation_slope_intercept`**](https://easystats.github.io/insight/reference/get_correlation_slope_intercept.html)
    *(insight)*
  - [**`get_data`**](https://easystats.github.io/insight/reference/get_data.html)
    *(insight)*
  - [**`get_parameters`**](https://easystats.github.io/insight/reference/get_parameters.html)
    *(insight)*
  - [**`get_predictors`**](https://easystats.github.io/insight/reference/get_predictors.html)
    *(insight)*
  - [**`get_priors`**](https://easystats.github.io/insight/reference/get_priors.html)
    *(insight)*
  - [**`get_random`**](https://easystats.github.io/insight/reference/get_random.html)
    *(insight)*
  - [**`get_response`**](https://easystats.github.io/insight/reference/get_response.html)
    *(insight)*
  - [**`get_variance_dispersion`**](https://easystats.github.io/insight/reference/get_variance_dispersion.html)
    *(insight)*
  - [**`get_variance_distribution`**](https://easystats.github.io/insight/reference/get_variance_distribution.html)
    *(insight)*
  - [**`get_variance_fixed`**](https://easystats.github.io/insight/reference/get_variance_fixed.html)
    *(insight)*
  - [**`get_variance_intercept`**](https://easystats.github.io/insight/reference/get_variance_intercept.html)
    *(insight)*
  - [**`get_variance_random`**](https://easystats.github.io/insight/reference/get_variance_random.html)
    *(insight)*
  - [**`get_variance_residual`**](https://easystats.github.io/insight/reference/get_variance_residual.html)
    *(insight)*
  - [**`get_variance_slope`**](https://easystats.github.io/insight/reference/get_variance_slope.html)
    *(insight)*
  - [**`get_variance`**](https://easystats.github.io/insight/reference/get_variance.html)
    *(insight)*
  - [**`hdi`**](https://easystats.github.io/bayestestR/reference/hdi.html)
    *(bayestestR)*
  - [**`icc`**](https://easystats.github.io/performance/reference/icc.html)
    *(performance)*
  - [**`interpret_bf`**](https://easystats.github.io/report/reference/interpret_bf.html)
    *(report)*
  - [**`interpret_d`**](https://easystats.github.io/report/reference/interpret_d.html)
    *(report)*
  - [**`interpret_direction`**](https://easystats.github.io/report/reference/interpret_direction.html)
    *(report)*
  - [**`interpret_odds`**](https://easystats.github.io/report/reference/interpret_odds.html)
    *(report)*
  - [**`interpret_omega_squared`**](https://easystats.github.io/report/reference/interpret_omega_squared.html)
    *(report)*
  - [**`interpret_p`**](https://easystats.github.io/report/reference/interpret_p.html)
    *(report)*
  - [**`interpret_r`**](https://easystats.github.io/report/reference/interpret_r.html)
    *(report)*
  - [**`interpret_r2`**](https://easystats.github.io/report/reference/interpret_r2.html)
    *(report)*
  - [**`interpret_rope`**](https://easystats.github.io/report/reference/interpret_rope.html)
    *(report)*
  - [**`interpret`**](https://easystats.github.io/report/reference/interpret.html)
    *(report)*
  - [**`is.int`**](https://easystats.github.io/report/reference/is.int.html)
    *(report)*
  - [**`is.report`**](https://easystats.github.io/report/reference/is.report.html)
    *(report)*
  - [**`is.rules`**](https://easystats.github.io/report/reference/is.rules.html)
    *(report)*
  - [**`is_multivariate`**](https://easystats.github.io/insight/reference/is_multivariate.html)
    *(insight)*
  - [**`item_difficulty`**](https://easystats.github.io/performance/reference/item_difficulty.html)
    *(performance)*
  - [**`item_intercor`**](https://easystats.github.io/performance/reference/item_intercor.html)
    *(performance)*
  - [**`item_reliability`**](https://easystats.github.io/performance/reference/item_reliability.html)
    *(performance)*
  - [**`item_split_half`**](https://easystats.github.io/performance/reference/item_split_half.html)
    *(performance)*
  - [**`kurtosis`**](https://easystats.github.io/parameters/reference/kurtosis.html)
    *(parameters)*
  - [**`link_function`**](https://easystats.github.io/insight/reference/link_function.html)
    *(insight)*
  - [**`link_inverse`**](https://easystats.github.io/insight/reference/link_inverse.html)
    *(insight)*
  - [**`looic`**](https://easystats.github.io/performance/reference/looic.html)
    *(performance)*
  - [**`map_estimate`**](https://easystats.github.io/bayestestR/reference/map_estimate.html)
    *(bayestestR)*
  - [**`model_bootstrap`**](https://easystats.github.io/parameters/reference/model_bootstrap.html)
    *(parameters)*
  - [**`model_info`**](https://easystats.github.io/insight/reference/model_info.html)
    *(insight)*
  - [**`model_parameters`**](https://easystats.github.io/parameters/reference/model_parameters.html)
    *(parameters)*
  - [**`model_performance`**](https://easystats.github.io/performance/reference/model_performance.html)
    *(performance)*
  - [**`model_values`**](https://easystats.github.io/report/reference/model_values.html)
    *(report)*
  - [**`mse`**](https://easystats.github.io/performance/reference/mse.html)
    *(performance)*
  - [**`n_obs`**](https://easystats.github.io/insight/reference/n_obs.html)
    *(insight)*
  - [**`normalize`**](https://easystats.github.io/parameters/reference/normalize.html)
    *(parameters)*
  - [**`null_model`**](https://easystats.github.io/performance/reference/null_model.html)
    *(performance)*
  - [**`odds_to_probs`**](https://easystats.github.io/parameters/reference/odds_to_probs.html)
    *(parameters)*
  - [**`omega_squared`**](https://easystats.github.io/parameters/reference/omega_squared.html)
    *(parameters)*
  - [**`overdispersion`**](https://easystats.github.io/performance/reference/overdispersion.html)
    *(performance)*
  - [**`p_direction`**](https://easystats.github.io/bayestestR/reference/p_direction.html)
    *(bayestestR)*
  - [**`p_map`**](https://easystats.github.io/bayestestR/reference/p_map.html)
    *(bayestestR)*
  - [**`p_rope`**](https://easystats.github.io/bayestestR/reference/p_rope.html)
    *(bayestestR)*
  - [**`p_value_kenward`**](https://easystats.github.io/parameters/reference/p_value_kenward.html)
    *(parameters)*
  - [**`p_value_wald`**](https://easystats.github.io/parameters/reference/p_value_wald.html)
    *(parameters)*
  - [**`p_value`**](https://easystats.github.io/parameters/reference/p_value.html)
    *(parameters)*
  - [**`print_color`**](https://easystats.github.io/insight/reference/print_color.html)
    *(insight)*
  - [**`print_colour`**](https://easystats.github.io/insight/reference/print_colour.html)
    *(insight)*
  - [**`r2_bayes`**](https://easystats.github.io/performance/reference/r2_bayes.html)
    *(performance)*
  - [**`r2_coxnell`**](https://easystats.github.io/performance/reference/r2_coxnell.html)
    *(performance)*
  - [**`r2_loo`**](https://easystats.github.io/performance/reference/r2_loo.html)
    *(performance)*
  - [**`r2_mcfadden`**](https://easystats.github.io/performance/reference/r2_mcfadden.html)
    *(performance)*
  - [**`r2_nagelkerke`**](https://easystats.github.io/performance/reference/r2_nagelkerke.html)
    *(performance)*
  - [**`r2_nakagawa`**](https://easystats.github.io/performance/reference/r2_nakagawa.html)
    *(performance)*
  - [**`r2_tjur`**](https://easystats.github.io/performance/reference/r2_tjur.html)
    *(performance)*
  - [**`r2`**](https://easystats.github.io/performance/reference/r2.html)
    *(performance)*
  - [**`remove_triangular`**](https://easystats.github.io/correlation/reference/remove_triangular.html)
    *(correlation)*
  - [**`rename_if_possible`**](https://easystats.github.io/report/reference/rename_if_possible.html)
    *(report)*
  - [**`report`**](https://easystats.github.io/report/reference/report.html)
    *(report)*
  - [**`reshape_draws`**](https://easystats.github.io/estimate/reference/reshape_draws.html)
    *(estimate)*
  - [**`rmse`**](https://easystats.github.io/performance/reference/rmse.html)
    *(performance)*
  - [**`rnorm_perfect`**](https://easystats.github.io/bayestestR/reference/rnorm_perfect.html)
    *(bayestestR)*
  - [**`rope_range`**](https://easystats.github.io/bayestestR/reference/rope_range.html)
    *(bayestestR)*
  - [**`rope`**](https://easystats.github.io/bayestestR/reference/rope.html)
    *(bayestestR)*
  - [**`rse`**](https://easystats.github.io/performance/reference/rse.html)
    *(performance)*
  - [**`rules`**](https://easystats.github.io/report/reference/rules.html)
    *(report)*
  - [**`show_packages`**](https://easystats.github.io/report/reference/show_packages.html)
    *(report)*
  - [**`skewness`**](https://easystats.github.io/parameters/reference/skewness.html)
    *(parameters)*
  - [**`smoothness`**](https://easystats.github.io/parameters/reference/smoothness.html)
    *(parameters)*
  - [**`standardize`**](https://easystats.github.io/parameters/reference/standardize.html)
    *(parameters)*
  - [**`to_fulltable`**](https://easystats.github.io/report/reference/to_fulltable.html)
    *(report)*
  - [**`to_fulltext`**](https://easystats.github.io/report/reference/to_fulltext.html)
    *(report)*
  - [**`to_table`**](https://easystats.github.io/report/reference/to_table.html)
    *(report)*
  - [**`to_text`**](https://easystats.github.io/report/reference/to_text.html)
    *(report)*
  - [**`to_values`**](https://easystats.github.io/report/reference/to_values.html)
    *(report)*
  - [**`zero_crossings`**](https://easystats.github.io/estimate/reference/zero_crossings.html)
    *(estimate)*
  - [**`zerocount`**](https://easystats.github.io/performance/reference/zerocount.html)
    *(performance)*
