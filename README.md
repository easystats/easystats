
# easystats

<p>

<img src='https://github.com/easystats/insight/raw/master/man/figures/logo.png' align="left" height="110" />
<img src='https://github.com/easystats/bayestestR/raw/master/man/figures/logo.png' align="left" height="110" />
<img src='https://github.com/easystats/parameters/raw/master/man/figures/logo.png' align="left" height="110" />
<img src='https://github.com/easystats/performance/raw/master/man/figures/logo.png' align="left" height="110" />
<img src='https://github.com/easystats/estimate/raw/master/man/figures/logo.png' align="left" height="110" />
<img src='https://github.com/easystats/correlation/raw/master/man/figures/logo.png' align="left" height="110" />
<img src='https://github.com/easystats/see/raw/master/man/figures/logo.png' align="left" height="110" />
<img src='https://github.com/easystats/report/raw/master/man/figures/logo.png' align="left" height="110" />

</p>

<p>

<br /><br /><br />

</p>

<p>

<br /><br /><br />

</p>

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

# Dependencies

![](man/figures/unnamed-chunk-3-1.png)<!-- -->

# Downloads

### Trend

<img src="man/figures/unnamed-chunk-5-1.png" style="display: block; margin: auto;" />

### By Week Day

<img src="man/figures/unnamed-chunk-6-1.png" style="display: block; margin: auto;" />

# List of functions

  - [**`%>%`**](https://easystats.github.io/report/reference/index.html)
    *(report)*
  - [**`all_models_equal`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`as.numeric_ifnumeric`**](https://easystats.github.io/estimate/reference/index.html)
    *(estimate)*
  - [**`as.report`**](https://easystats.github.io/report/reference/index.html)
    *(report)*
  - [**`bayesfactor_savagedickey`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`bayesfactor`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`binned_residuals`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`check_convergence`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`check_overdispersion`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`check_singularity`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`check_zeroinflation`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`ci_wald`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`ci`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`cite_packages`**](https://easystats.github.io/report/reference/index.html)
    *(report)*
  - [**`clean_names`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`compare_performance`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`convert_d_to_r`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`convert_odds_to_d`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`convert_odds_to_probs`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`convert_r_to_d`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`cor_test`**](https://easystats.github.io/correlation/reference/index.html)
    *(correlation)*
  - [**`correlation`**](https://easystats.github.io/correlation/reference/index.html)
    *(correlation)*
  - [**`cronbachs_alpha`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`d_to_r`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`data_grid`**](https://easystats.github.io/estimate/reference/index.html)
    *(estimate)*
  - [**`density_at`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`describe_posterior`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`dof_kenward`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`download_model`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`equivalence_test`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`error_rate`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`estimate_contrasts`**](https://easystats.github.io/estimate/reference/index.html)
    *(estimate)*
  - [**`estimate_fit`**](https://easystats.github.io/estimate/reference/index.html)
    *(estimate)*
  - [**`estimate_means`**](https://easystats.github.io/estimate/reference/index.html)
    *(estimate)*
  - [**`estimate_response`**](https://easystats.github.io/estimate/reference/index.html)
    *(estimate)*
  - [**`estimate_slopes`**](https://easystats.github.io/estimate/reference/index.html)
    *(estimate)*
  - [**`estimate_smooth`**](https://easystats.github.io/estimate/reference/index.html)
    *(estimate)*
  - [**`find_algorithm`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`find_distribution`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`find_formula`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`find_parameters`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`find_predictors`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`find_random_slopes`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`find_random`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`find_response`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`find_terms`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`find_variables`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`format_algorithm`**](https://easystats.github.io/report/reference/index.html)
    *(report)*
  - [**`format_bf`**](https://easystats.github.io/report/reference/index.html)
    *(report)*
  - [**`format_ci`**](https://easystats.github.io/report/reference/index.html)
    *(report)*
  - [**`format_model`**](https://easystats.github.io/report/reference/index.html)
    *(report)*
  - [**`format_p`**](https://easystats.github.io/report/reference/index.html)
    *(report)*
  - [**`format_pd`**](https://easystats.github.io/report/reference/index.html)
    *(report)*
  - [**`format_rope`**](https://easystats.github.io/report/reference/index.html)
    *(report)*
  - [**`format_text_collapse`**](https://easystats.github.io/report/reference/index.html)
    *(report)*
  - [**`format_text_wrap`**](https://easystats.github.io/report/reference/index.html)
    *(report)*
  - [**`format_value_unless_integers`**](https://easystats.github.io/report/reference/index.html)
    *(report)*
  - [**`format_value`**](https://easystats.github.io/report/reference/index.html)
    *(report)*
  - [**`generalized_inverse`**](https://easystats.github.io/correlation/reference/index.html)
    *(correlation)*
  - [**`get_correlation_slope_intercept`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`get_data`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`get_parameters`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`get_predictors`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`get_priors`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`get_random`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`get_response`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`get_variance_dispersion`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`get_variance_distribution`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`get_variance_fixed`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`get_variance_intercept`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`get_variance_random`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`get_variance_residual`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`get_variance_slope`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`get_variance`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`hdi`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`hosmer_lemeshow`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`icc`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`interpret_bf`**](https://easystats.github.io/report/reference/index.html)
    *(report)*
  - [**`interpret_d`**](https://easystats.github.io/report/reference/index.html)
    *(report)*
  - [**`interpret_direction`**](https://easystats.github.io/report/reference/index.html)
    *(report)*
  - [**`interpret_effective_sample`**](https://easystats.github.io/report/reference/index.html)
    *(report)*
  - [**`interpret_odds`**](https://easystats.github.io/report/reference/index.html)
    *(report)*
  - [**`interpret_omega_squared`**](https://easystats.github.io/report/reference/index.html)
    *(report)*
  - [**`interpret_p`**](https://easystats.github.io/report/reference/index.html)
    *(report)*
  - [**`interpret_r`**](https://easystats.github.io/report/reference/index.html)
    *(report)*
  - [**`interpret_r2`**](https://easystats.github.io/report/reference/index.html)
    *(report)*
  - [**`interpret_rhat`**](https://easystats.github.io/report/reference/index.html)
    *(report)*
  - [**`interpret_rope`**](https://easystats.github.io/report/reference/index.html)
    *(report)*
  - [**`interpret`**](https://easystats.github.io/report/reference/index.html)
    *(report)*
  - [**`is.int`**](https://easystats.github.io/report/reference/index.html)
    *(report)*
  - [**`is.report`**](https://easystats.github.io/report/reference/index.html)
    *(report)*
  - [**`is.rules`**](https://easystats.github.io/report/reference/index.html)
    *(report)*
  - [**`is_model`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`is_multivariate`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`item_difficulty`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`item_intercor`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`item_reliability`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`item_split_half`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`kurtosis`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`link_function`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`link_inverse`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`looic`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`map_estimate`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`marginal_parameters`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`model_bootstrap`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`model_info`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`model_parameters`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`model_performance`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`model_values`**](https://easystats.github.io/report/reference/index.html)
    *(report)*
  - [**`mse`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`n_obs`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`normalize`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`odds_to_d`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`odds_to_probs`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`omega_squared`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`p_direction`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`p_map`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`p_rope`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`p_value_kenward`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`p_value_wald`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`p_value`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`pd`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`principal_components`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`print_color`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`print_colour`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`r_to_d`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`r2_bayes`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`r2_coxnell`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`r2_kl`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`r2_loo`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`r2_mcfadden`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`r2_nagelkerke`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`r2_nakagawa`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`r2_tjur`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`r2`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`rcauchy_perfect`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`remove_triangular`**](https://easystats.github.io/correlation/reference/index.html)
    *(correlation)*
  - [**`rename_if_possible`**](https://easystats.github.io/report/reference/index.html)
    *(report)*
  - [**`report`**](https://easystats.github.io/report/reference/index.html)
    *(report)*
  - [**`reshape_draws`**](https://easystats.github.io/estimate/reference/index.html)
    *(estimate)*
  - [**`rmse`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`rnorm_perfect`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`rope_range`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`rope`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`rpois_perfect`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`rse`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`rt_perfect`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`rules`**](https://easystats.github.io/report/reference/index.html)
    *(report)*
  - [**`show_packages`**](https://easystats.github.io/report/reference/index.html)
    *(report)*
  - [**`skewness`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`smoothness`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`standardize_parameters`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`standardize`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`to_fulltable`**](https://easystats.github.io/report/reference/index.html)
    *(report)*
  - [**`to_fulltext`**](https://easystats.github.io/report/reference/index.html)
    *(report)*
  - [**`to_table`**](https://easystats.github.io/report/reference/index.html)
    *(report)*
  - [**`to_text`**](https://easystats.github.io/report/reference/index.html)
    *(report)*
  - [**`to_values`**](https://easystats.github.io/report/reference/index.html)
    *(report)*
  - [**`zero_crossings`**](https://easystats.github.io/estimate/reference/index.html)
    *(estimate)*
