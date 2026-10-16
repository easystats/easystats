# List all arguments used in easystats packages

This function returns a list with all arguments that are used across all
easystats packages

## Usage

``` r
easystats_arguments(
  packages = "all",
  argument = NULL,
  method = NULL,
  flatten = FALSE
)
```

## Arguments

- packages:

  String, name of the easystats-package, or `"all"` to include all
  packages.

- argument:

  String, name of an argument to search for. If provided, all methods
  that contain this argument are returned. `argument` and `method` can
  be combined.

- method:

  String, name of a method to search for. If provided, all arguments for
  this method (for all classes that are supported) are returned.
  `argument` and `method` can be combined.

- flatten:

  If `TRUE`, returns only one element and each argument only once.

## Value

A named list with argument names used in the different packages.

## Examples

``` r
# \dontrun{
easystats_arguments()
#> $bayestestR
#>  [1] "BF"              "as_p"            "bf_prior"        "bw"             
#>  [5] "by"              "caption"         "centrality"      "ci"             
#>  [9] "ci_method"       "ci_string"       "complement"      "component"      
#> [13] "cp"              "denominator"     "diagnostic"      "digits"         
#> [17] "direction"       "dispersion"      "effects"         "exact"          
#> [21] "extend"          "extend_scale"    "format"          "hypothesis"     
#> [25] "index"           "iterations"      "keep_iterations" "log"            
#> [29] "magnitude"       "match_models"    "mediator"        "method"         
#> [33] "missing"         "model"           "models"          "n"              
#> [37] "n_obs"           "newdata"         "null"            "object"         
#> [41] "parameters"      "pd"              "posterior"       "precision"      
#> [45] "prior"           "prior_odds"      "priors"          "range"          
#> [49] "reference"       "remove_na"       "response"        "rope_ci"        
#> [53] "rope_range"      "rvar_col"        "scale_multiply"  "select"         
#> [57] "show_names"      "simulate_priors" "stack"           "subset"         
#> [61] "subtitles"       "summary"         "test"            "threshold"      
#> [65] "treatment"       "use_iterations"  "verbose"         "which"          
#> [69] "x"              
#> 
#> $correlation
#>  [1] "bf_exact"             "cols"                 "cor"                 
#>  [4] "data"                 "diag"                 "digits"              
#>  [7] "distance"             "format"               "hclust_method"       
#> [10] "include_significance" "labs"                 "method"              
#> [13] "object"               "p_digits"             "pcor"                
#> [16] "point"                "redundant"            "scale"               
#> [19] "scale_fill"           "show_data"            "show_legend"         
#> [22] "show_text"            "smooth"               "stars"               
#> [25] "target"               "text"                 "tile"                
#> [28] "tol"                  "type"                 "verbose"             
#> [31] "x"                    "zap_small"           
#> 
#> $datawizard
#>  [1] ".at"               ".if"               ".modify"          
#>  [4] "add"               "add_total"         "append"           
#>  [7] "as_data_frame"     "big_mark"          "breaks"           
#> [10] "by"                "call"              "center"           
#> [13] "centrality"        "ci"                "ci_brackets"      
#> [16] "ci_width"          "collapse"          "data"             
#> [19] "default"           "digits"            "dispersion"       
#> [22] "drop_levels"       "dummy_factors"     "exclude"          
#> [25] "extract"           "font_size"         "force"            
#> [28] "format"            "id"                "ignore_case"      
#> [31] "include_bounds"    "include_factors"   "include_response" 
#> [34] "include_total_row" "iqr"               "iterations"       
#> [37] "join"              "keep"              "labels"           
#> [40] "labels_to_levels"  "lag"               "line_padding"     
#> [43] "lowest"            "method"            "metrics"          
#> [46] "mu"                "multiply"          "n"                
#> [49] "n_groups"          "na"                "name"             
#> [52] "object"            "optional"          "preserve_levels"  
#> [55] "preserve_na"       "proportions"       "quartiles"        
#> [58] "range"             "recode"            "reference"        
#> [61] "regex"             "remove_na"         "replace_char"     
#> [64] "replace_fac"       "replace_num"       "replacement"      
#> [67] "robust"            "row.names"         "row_color"        
#> [70] "safe"              "scale"             "select"           
#> [73] "sigma"             "sign"              "simplify"         
#> [76] "split"             "stringsAsFactors"  "suffix"           
#> [79] "test"              "threshold"         "to"               
#> [82] "trim"              "two_sd"            "type"             
#> [85] "values"            "var"               "variable"         
#> [88] "verbose"           "weights"           "width"            
#> [91] "x"                 "y"                 "zeros"            
#> 
#> $easystats
#> [1] "format" "object" "x"     
#> 
#> $effectsize
#>  [1] "OR"          "RR"          "alternative" "append_CLES" "ci"         
#>  [6] "d"           "digits"      "draws"       "drop"        "generalized"
#> [11] "log"         "model"       "name"        "output"      "p0"         
#> [16] "partial"     "range"       "rb"          "rule"        "rules"      
#> [21] "ss_function" "test"        "transform"   "type"        "use_symbols"
#> [26] "verbose"     "x"          
#> 
#> $insight
#>   [1] "CI_high"             "CI_low"              "REML"               
#>   [4] "abbreviate"          "adjust"              "allow.new.levels"   
#>   [7] "approximation"       "as_percent"          "as_proportion"      
#>  [10] "as_term_labels"      "big_mark"            "brackets"           
#>  [13] "by"                  "centrality"          "character_only"     
#>  [16] "check_response"      "ci"                  "ci_method"          
#>  [19] "ci_string"           "ci_type"             "cluster.rand"       
#>  [22] "cluster_size"        "column"              "column_index"       
#>  [25] "combine"             "complete"            "component"          
#>  [28] "data"                "decimal_point"       "dichotomies"        
#>  [31] "digits"              "disaggregate"        "dispersion_method"  
#>  [34] "effects"             "estimator"           "factors"            
#>  [37] "family"              "flatten"             "format"             
#>  [40] "group"               "ignore_estimate"     "include_all"        
#>  [43] "include_call"        "include_data"        "include_formula"    
#>  [46] "include_interval"    "include_names"       "include_random"     
#>  [49] "include_response"    "include_smooth"      "iterations"         
#>  [52] "keep_iterations"     "kr"                  "lead_zero"          
#>  [55] "length"              "merge_parameters"    "missing"            
#>  [58] "model"               "model_component"     "n_bins"             
#>  [61] "na.action"           "newparams"           "null_as_ones"       
#>  [64] "null_model"          "numerics"            "object"             
#>  [67] "objects"             "only_models"         "parameters"         
#>  [70] "population_size"     "predict"             "predictions"        
#>  [73] "preserve_range"      "progress"            "protect_integers"   
#>  [76] "range"               "re.form"             "re_test"            
#>  [79] "reference"           "remove_na"           "remove_nonestimable"
#>  [82] "response"            "robust"              "se"                 
#>  [85] "seed"                "select"              "separator"          
#>  [88] "shape"               "source"              "split_nested"       
#>  [91] "standardize"         "statistic"           "style"              
#>  [94] "style_negative"      "style_positive"      "submodel"           
#>  [97] "summary"             "tolerance"           "transf"             
#> [100] "transf_args"         "type"                "use.u"              
#> [103] "variables"           "vcov"                "vcov_args"          
#> [106] "verbose"             "weighted"            "what"               
#> [109] "width"               "width_high"          "width_low"          
#> [112] "x"                   "zap_small"          
#> 
#> $modelbased
#>  [1] "backend"             "by"                  "ci"                 
#>  [4] "collapse_group"      "comparison"          "contrast"           
#>  [7] "data"                "diagnostic"          "dispersion"         
#> [10] "effectsize"          "es_type"             "estimate"           
#> [13] "facet"               "format"              "full_labels"        
#> [16] "grid"                "group"               "include_grid"       
#> [19] "include_response"    "indices"             "iterations"         
#> [22] "join_dots"           "keep_iterations"     "line"               
#> [25] "method"              "model"               "numeric_as_discrete"
#> [28] "object"              "optional"            "p_adjust"           
#> [31] "point"               "pointrange"          "post_process"       
#> [34] "predict"             "predictor_name"      "preserve_names"     
#> [37] "ribbon"              "robust"              "row.names"          
#> [40] "select"              "show_data"           "show_residuals"     
#> [43] "strength"            "stringsAsFactors"    "test"               
#> [46] "transform"           "type"                "use_responsename"   
#> [49] "verbose"             "x"                   "y"                  
#> 
#> $performance
#>  [1] "ID"                "adjust"            "alpha"            
#>  [4] "alpha_dot"         "alternative"       "average"          
#>  [7] "bandwidth"         "base_size"         "by"               
#> [10] "caption"           "check"             "check_range"      
#> [13] "ci"                "colors"            "component"        
#> [16] "correct_bounds"    "detrend"           "digits"           
#> [19] "distribution"      "effects"           "estimator"        
#> [22] "factor_method"     "flatten"           "format"           
#> [25] "include_by"        "include_formula"   "iterations"       
#> [28] "k"                 "layout"            "maximum_dots"     
#> [31] "method"            "metrics"           "model"            
#> [34] "multivariate"      "n"                 "n_obs"            
#> [37] "nsim"              "numeric_as_factor" "object"           
#> [40] "objects"           "optional"          "outlier_values"   
#> [43] "p_digits"          "panel"             "poly_cor"         
#> [46] "ppc_range"         "predictors"        "prior_odds"       
#> [49] "quantile_function" "re_formula"        "reference"        
#> [52] "residual_type"     "rotation"          "row.names"        
#> [55] "select"            "show_ci"           "show_dots"        
#> [58] "size_axis_title"   "size_dot"          "size_line"        
#> [61] "size_title"        "text_length"       "theme"            
#> [64] "threshold"         "time"              "tolerance"        
#> [67] "tolerance_factor"  "tolerance_numeric" "type"             
#> [70] "verbose"           "x"                 "x_limits"         
#> [73] "zap_small"        
#> 
#> $parameters
#>   [1] "adjust"              "align"               "alternative"        
#>   [4] "as_draws"            "bf_prior"            "bootstrap"          
#>   [7] "brackets"            "caption"             "centrality"         
#>  [10] "ci"                  "ci_brackets"         "ci_digits"          
#>  [13] "ci_method"           "ci_random"           "ci_width"           
#>  [16] "cluster"             "cluster_groups"      "clusters"           
#>  [19] "column"              "column_labels"       "column_width"       
#>  [22] "component"           "data"                "df_error"           
#>  [25] "diagnostic"          "digits"              "direction"          
#>  [28] "dispersion"          "distance"            "dof"                
#>  [31] "drop"                "drop_parameters"     "effects"            
#>  [34] "es_type"             "exponentiate"        "factor_method"      
#>  [37] "font_size"           "footer"              "footer_digits"      
#>  [40] "force"               "format"              "group_level"        
#>  [43] "groups"              "include_ENP"         "include_IC"         
#>  [46] "include_info"        "include_intercept"   "include_proportions"
#>  [49] "include_pseudo"      "include_reference"   "include_response"   
#>  [52] "include_sigma"       "include_studies"     "iterations"         
#>  [55] "k"                   "keep"                "keep_na"            
#>  [58] "keep_parameters"     "labels"              "line_padding"       
#>  [61] "loadings_columns"    "max_per_dimension"   "method"             
#>  [64] "model"               "n"                   "n_cpus"             
#>  [67] "n_obs"               "names"               "newdata"            
#>  [70] "null"                "object"              "optional"           
#>  [73] "p_adjust"            "p_digits"            "parallel"           
#>  [76] "power"               "pretty_names"        "priors"             
#>  [79] "range"               "re_test"             "robust"             
#>  [82] "rope_ci"             "rope_range"          "rotation"           
#>  [85] "row.names"           "rule"                "select"             
#>  [88] "show_data"           "show_formula"        "show_sigma"         
#>  [91] "sort"                "sparse"              "split_components"   
#>  [94] "standardize"         "steps"               "subtitle"           
#>  [97] "table_wide"          "test"                "threshold"          
#> [100] "two_sd"              "type"                "vcov"               
#> [103] "vcov_args"           "verbose"             "wb_component"       
#> [106] "x"                   "zap_small"          
#> 
#> $report
#>  [1] "as_is"              "centrality"         "digits"            
#>  [4] "dispersion"         "distribution"       "effectsize"        
#>  [7] "effectsize_method"  "exact"              "h0"                
#> [10] "h1"                 "include_ENP"        "include_IC"        
#> [13] "include_R"          "include_diagnostic" "include_effectsize"
#> [16] "include_intercept"  "interpretation"     "layout"            
#> [19] "levels_percentage"  "missing_percentage" "n"                 
#> [22] "n_entries"          "object"             "parameters"        
#> [25] "prefix"             "protect_ratio"      "range"             
#> [28] "summary"            "table"              "what"              
#> [31] "width"              "x"                 
#> 
#> $see
#>  [1] "alpha"                 "alpha_boxplot"         "alpha_dispersion"     
#>  [4] "alpha_dot"             "alpha_line"            "alpha_posteriors"     
#>  [7] "alpha_priors"          "alpha_rope"            "alpha_si"             
#> [10] "arrow_end_gap"         "base_size"             "caption"              
#> [13] "centrality"            "check_colliders"       "ci"                   
#> [16] "color_dispersion"      "color_error_bar"       "color_fill"           
#> [19] "color_highlight"       "color_rope"            "color_si"             
#> [22] "color_text"            "colors"                "component"            
#> [25] "data"                  "detrend"               "dispersion"           
#> [28] "dispersion_style"      "dodge_position"        "effect"               
#> [31] "elbow_threshold"       "error_bar"             "factor_node_size"     
#> [34] "fill_factors"          "fill_variables"        "grid"                 
#> [37] "highlight"             "label_values"          "log"                  
#> [40] "log_scale"             "margins"               "method"               
#> [43] "n_columns"             "n_pies"                "na_label"             
#> [46] "names_factors"         "normalize_height"      "panel"                
#> [49] "predictor"             "prior_odds"            "priors"               
#> [52] "rescale_distance"      "show_density"          "show_direction"       
#> [55] "show_estimate"         "show_intercept"        "show_interval"        
#> [58] "show_labels"           "show_na"               "show_smooth"          
#> [61] "show_title"            "show_zero"             "size"                 
#> [64] "size_arrow"            "size_axis_title"       "size_bar"             
#> [67] "size_boxplot"          "size_line"             "size_point"           
#> [70] "size_text"             "size_title"            "sort"                 
#> [73] "stack"                 "style"                 "support_only"         
#> [76] "theme"                 "threshold_coefficient" "threshold_p"          
#> [79] "title"                 "transform"             "type"                 
#> [82] "value"                 "verbose"               "weight_points"        
#> [85] "which"                 "x"                     "x_limits"             
#> 

easystats_arguments(argument = "dispersion")
#> $bayestestR
#>  [1] "describe_posterior.BFBayesFactor"        
#>  [2] "describe_posterior.BGGM"                 
#>  [3] "describe_posterior.CmdStanFit"           
#>  [4] "describe_posterior.MCMCglmm"             
#>  [5] "describe_posterior.bamlss"               
#>  [6] "describe_posterior.bayesQR"              
#>  [7] "describe_posterior.bcplm"                
#>  [8] "describe_posterior.blavaan"              
#>  [9] "describe_posterior.blrm"                 
#> [10] "describe_posterior.brmsfit"              
#> [11] "describe_posterior.comparisons"          
#> [12] "describe_posterior.data.frame"           
#> [13] "describe_posterior.double"               
#> [14] "describe_posterior.draws"                
#> [15] "describe_posterior.effectsize_std_params"
#> [16] "describe_posterior.emmGrid"              
#> [17] "describe_posterior.emm_list"             
#> [18] "describe_posterior.get_predicted"        
#> [19] "describe_posterior.mcmc"                 
#> [20] "describe_posterior.mcmc.list"            
#> [21] "describe_posterior.numeric"              
#> [22] "describe_posterior.predictions"          
#> [23] "describe_posterior.rvar"                 
#> [24] "describe_posterior.sim"                  
#> [25] "describe_posterior.sim.merMod"           
#> [26] "describe_posterior.slopes"               
#> [27] "describe_posterior.stanfit"              
#> [28] "describe_posterior.stanmvreg"            
#> [29] "describe_posterior.stanreg"              
#> [30] "point_estimate.BFBayesFactor"            
#> [31] "point_estimate.BGGM"                     
#> [32] "point_estimate.CmdStanFit"               
#> [33] "point_estimate.MCMCglmm"                 
#> [34] "point_estimate.bamlss"                   
#> [35] "point_estimate.bayesQR"                  
#> [36] "point_estimate.bcplm"                    
#> [37] "point_estimate.blavaan"                  
#> [38] "point_estimate.blrm"                     
#> [39] "point_estimate.brmsfit"                  
#> [40] "point_estimate.comparisons"              
#> [41] "point_estimate.data.frame"               
#> [42] "point_estimate.draws"                    
#> [43] "point_estimate.emmGrid"                  
#> [44] "point_estimate.emm_list"                 
#> [45] "point_estimate.get_predicted"            
#> [46] "point_estimate.mcmc"                     
#> [47] "point_estimate.mcmc.list"                
#> [48] "point_estimate.numeric"                  
#> [49] "point_estimate.predictions"              
#> [50] "point_estimate.rvar"                     
#> [51] "point_estimate.sim"                      
#> [52] "point_estimate.sim.merMod"               
#> [53] "point_estimate.slopes"                   
#> [54] "point_estimate.stanfit"                  
#> [55] "point_estimate.stanreg"                  
#> 
#> $datawizard
#> [1] "describe_distribution.character"  "describe_distribution.data.frame"
#> [3] "describe_distribution.factor"     "describe_distribution.grouped_df"
#> [5] "describe_distribution.list"       "describe_distribution.numeric"   
#> 
#> $modelbased
#> [1] "estimate_grouplevel.brmsfit" "estimate_grouplevel.stanreg"
#> 
#> $parameters
#>  [1] "model_parameters.BFBayesFactor" "model_parameters.BGGM"         
#>  [3] "model_parameters.MCMCglmm"      "model_parameters.bamlss"       
#>  [5] "model_parameters.bayesQR"       "model_parameters.bcplm"        
#>  [7] "model_parameters.befa"          "model_parameters.blavaan"      
#>  [9] "model_parameters.blrm"          "model_parameters.brmsfit"      
#> [11] "model_parameters.draws"         "model_parameters.emmGrid"      
#> [13] "model_parameters.stanfit"       "model_parameters.stanmvreg"    
#> [15] "model_parameters.stanreg"      
#> 
#> $report
#>  [1] "report.data.frame"            "report.grouped_df"           
#>  [3] "report.numeric"               "report_parameters.data.frame"
#>  [5] "report_parameters.grouped_df" "report_parameters.numeric"   
#>  [7] "report_statistics.data.frame" "report_statistics.grouped_df"
#>  [9] "report_statistics.numeric"    "report_table.data.frame"     
#> [11] "report_table.grouped_df"      "report_table.numeric"        
#> [13] "report_text.data.frame"       "report_text.grouped_df"      
#> [15] "report_text.numeric"         
#> 
#> $see
#> [1] "plot.see_parameters_distribution"
#> 

easystats_arguments(method = "get_parameters")
#> $insight
#>  [1] "centrality"       "component"        "effects"          "iterations"      
#>  [5] "merge_parameters" "parameters"       "progress"         "standardize"     
#>  [9] "summary"          "verbose"          "x"               
#> 

out <- easystats_arguments(method = "describe_posterior", argument = "dispersion")
insight::export_table(out, format = "html")


  

Function
```
