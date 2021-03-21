
# easystats

<p>

<a href = "https://github.com/easystats/insight"><img src='https://github.com/easystats/insight/raw/master/man/figures/logo.png' align="left" height="84" /></a>
<a href = "https://github.com/easystats/bayestestR"><img src='https://github.com/easystats/bayestestR/raw/master/man/figures/logo.png' align="left" height="84" /></a>
<a href = "https://github.com/easystats/parameters"><img src='https://github.com/easystats/parameters/raw/main/man/figures/logo.png' align="left" height="84" /></a>
<a href = "https://github.com/easystats/performance"><img src='https://github.com/easystats/performance/raw/master/man/figures/logo.png' align="left" height="84" /></a>
<a href = "https://github.com/easystats/effectsize"><img src='https://github.com/easystats/effectsize/raw/main/man/figures/logo.png' align="left" height="84" /></a>
<a href = "https://github.com/easystats/modelbased"><img src='https://github.com/easystats/modelbased/raw/master/man/figures/logo.png' align="left" height="84" /></a>
<a href = "https://github.com/easystats/correlation"><img src='https://github.com/easystats/correlation/raw/master/man/figures/logo.png' align="left" height="84" /></a>
<a href = "https://github.com/easystats/see"><img src='https://github.com/easystats/see/raw/master/man/figures/logo.png' align="left" height="84" /></a>
<a href = "https://github.com/easystats/report"><img src='https://github.com/easystats/report/raw/master/man/figures/logo.png' align="left" height="84" /></a>
<br />

</p>

<br />

.

## What is *easystats*?

**easystats** is a collection of R packages, which aims to provide a
unifying and consistent framework to tame, discipline and harness the
scary R statistics and their pesky models.

However, there is not (yet) an unique **“easystats” way of doing data
analysis**. Instead, start with one package and, when you’ll face a new
challenge, do check if there is an easystats answer for it in other
packages. You will slowly uncover how using them together facilitates
your life. And who knows, you might even end up using them all. ***Gotta
catch ’em all\!*** <!-- 'tis a pokémon reference for y'all grandpas -->

## Where to start

Each **easystats** package has a different scope and purpose. This means
you the **best way to start** is to explore and pick the one(s) that you
feel might be useful to you. However, as they are built with a “bigger
picture” in mind, you will realize that using more of them creates a
smooth workflow, as these packages are meant to work together.

  - [**report**](https://github.com/easystats/report): 📜 🎉 Automated
    statistical reporting of objects in R
  - [**correlation**](https://github.com/easystats/correlation): 🔗 Your
    all-in-one package to run correlations
  - [**modelbased**](https://github.com/easystats/modelbased): 📈
    Estimate effects, group averages and contrasts between groups based
    on statistical models
  - [**bayestestR**](https://github.com/easystats/bayestestR): 👻 Great
    for beginners or experts of Bayesian statistics
  - [**parameters**](https://github.com/easystats/parameters): 📊 Obtain
    a table containing all information about the parameters of your
    models
  - [**performance**](https://github.com/easystats/performance): 💪
    Models’ quality and performance metrics (R2, ICC, LOO, AIC, BF, …)
  - [**effectsize**](https://github.com/easystats/effectsize): 🐉
    Compute, convert, interpret and work with indices of effect size and
    standardized parameters
  - [**insight**](https://github.com/easystats/insight): 🔮 For
    developers, a package to help you work with different models and
    packages
  - [**see**](https://github.com/easystats/see): 🎨 The plotting
    companion to create beautiful results visualizations

## Frequently Asked Questions

  - **How is *easystats* different from the *tidyverse*?**

You’ve probably already heard about the
[**tidyverse**](https://www.tidyverse.org/), another very popular
collection of packages (*ggplot*, *dplyr*, *tidyr*, …) that also makes
using R easier. So, should you pick the *tidyverse* or *easystats*?
**Pick both\!** Indeed, they do not serve the same purpose. The
*tidyverse* packages are primarily made to create a new R experience,
where data manipulation and exploration is natural and consistent. On
the other hand, **easystats** is more focused on helping you making this
last mile from the analysis to your manuscript or stats report. It helps
you understand and interpret your results and report them following best
practices. You can definitely use the *easystats* functions in a
*tidyverse* workflow\!

**easystats + tidyverse =** ❤️

  - **Can *easystats* be useful to advanced users and/or developers?**

Yes, definitely\! **easystats** is built in terms of modules that are
general enough so that they can be used inside of other packages. For
instance, the *insight* package is made to easily implement support for
post-processing of all the models and packages under the sun. We use it
in all the easystats packages, but it also used for instance in
[**ggstatsplot**](https://github.com/IndrajeetPatil/ggstatsplot),
[**ggeffects**](https://github.com/strengejacke/ggeffects), and more.
**So why not in yours**? Moreover, the easystats packages are very
lightweight, with a minimal set of dependencies, which again makes it
great if you want to rely on them.

## Installation

The whole `easystats` suite can be installed *at once* with the
following:

``` r
install.packages("devtools")
devtools::install_github("easystats/easystats")
```

``` r
library("easystats")
```

## Related posts

  - [Comparison of indices of significance in the Bayesian
    framework](https://easystats.github.io/blog/posts/bayestestr_evidence_ani/)
  - [News from easystats: updated parameters and see
    packages](https://easystats.github.io/blog/posts/parameters_and_see_update/)
  - [parameters: a powerful and lightweight alternative to broom to
    describe your models’
    coefficients](https://easystats.github.io/blog/posts/parameters_presentation/)
  - [Check your (Mixed) Model for Multicollinearity with
    ‘performance’](https://easystats.github.io/blog/posts/performance_check_collinearity/)
  - [Testing Contrasts from Bayesian Models with ‘emmeans’ and
    ‘bayestestR’](https://easystats.github.io/blog/posts/bayestestr_emmeans/)
  - [Become a Bayesian master with bayestestR
    (0.2)](https://easystats.github.io/blog/posts/bayestestr_v2/)
  - [The ‘see’ package: beautiful figures for
    easystats](https://easystats.github.io/blog/posts/see_presentation/)
  - [Compute R2s and other performance indices for all your
    models\!](https://easystats.github.io/blog/posts/performance_presentation/)
  - [Describe and understand Bayesian models and posteriors using
    bayestestR](https://easystats.github.io/blog/posts/bayestestr_presentation/)
  - [A unified syntax for accessing models’
    information](https://easystats.github.io/blog/posts/insight_presentation/)
  - [The end of errors in ANOVA
    reporting](https://easystats.github.io/blog/posts/report_anova/)

Find an overview of all postings
[here](https://easystats.github.io/blog/posts/).

## Dependencies

Most of *easystats* packages are very lightweight, *i.e.*, they don’t
rely nor import any other packages\! This means that you can safely use
them as dependencies in your own packages, without the risk of butterfly
effects (a small change in a distant downstream dependency with
unexpected upstream consequences).

There is one exception. The [**see**](http://easystats.github.io/see)
package is one of our high-level packages that is responsible for
plotting and creating figures, relying thus on other packages such as
*ggplot2*, which itself is plugged in the *tidyverse*, increasing
package dependencies by a substantial amount. On the bright side of
things, it gives a good **overview of the place of *easystats* in the R
ecosystem**.

## Citation

How to reference *easystats*?

1.  **Cite specific packages**

The most parsimonious approach is to cite only the particular package
that helped you, e.g., “using *bayestestR* (Makowski, Ben-Shachar, &
Lüdecke, 2019)”. However, as *easystats* is meant to be an ecosystem,
with different people working on its different aspects (some being more
“citeable” than others), please consider including also the “main”
publication: [***not available
yet***](https://github.com/easystats/easystats/issues/24).

2.  **Cite the whole ecosystem** :heart:

Want to credit the whole network of interconnected aspects of
*easystats*? This can be done with a sentence like the following:

> **Data processing was carried out with R (R Core Team, 2019) and the
> *easystats* ecosystem (Lüdecke, Waggoner, & Makowski, 2019; Makowski,
> Ben-Shachar, & Lüdecke, 2019; Makowski, Ben-Shachar, Patil, & Lüdecke,
> 2020; Lüdecke, Ben-Shachar, Patil, & Makowski, 2020; Ben-Shachar,
> Lüdecke, & Makowski, 2020)**

  - Lüdecke, D., Waggoner, P. D., & Makowski, D. (2019). insight: A
    Unified Interface to Access Information from Model Objects in R.
    *Journal of Open Source Software*, *4*, 1412. doi:
    10.21105/joss.01412
  - Makowski, D., Ben-Shachar, M.S., & Lüdecke, D. (2019). bayestestR:
    Describing Effects and their Uncertainty, Existence and Significance
    within the Bayesian Framework. *Journal of Open Source Software*,
    *4*(40), 1541. 10.21105/joss.01541
  - Makowski, D., Ben-Shachar, M.S., Patil, I., & Lüdecke, D. (2019).
    Methods and Algorithms for Correlation Analysis in R. *Journal of
    Open Source Software*, *5*(51), 2306. 10.21105/joss.02306  
  - Lüdecke, D., Ben-Shachar, M.S., Patil, I., Makowski, D. (2020).
    parameters: Extracting, Computing and Exploring the Parameters of
    Statistical Models using R. *Journal of Open Source Software*,
    *5*(53), 2445. doi: 10.21105/joss.02445
  - Ben-Shachar, M.S., Lüdecke, D., Makowski, D. (2020). effectsize:
    Estimation of Effect Size Indices and Standardized Parameters.
    *Journal of Open Source Software*, *5*(56), 2815. doi:
    10.21105/joss.02815

<details>

<summary>Click here to see the corresponding APA and bibtex
entries</summary>

<br>

    @article{ludecke2019insight,
        journal = {Journal of Open Source Software},
        doi = {10.21105/joss.01412},
        issn = {2475-9066},
        number = {38},
        publisher = {The Open Journal},
        title = {insight: A Unified Interface to Access Information from Model Objects in R},
        url = {http://dx.doi.org/10.21105/joss.01412},
        volume = {4},
        author = {Lüdecke, Daniel and Waggoner, Philip and Makowski, Dominique},
        pages = {1412},
        date = {2019-06-25},
        year = {2019},
        month = {6},
        day = {25}
    }
    
    
    @article{makowski2019bayestestr,
        title = {{bayestestR}: {Describing} {Effects} and their {Uncertainty}, {Existence} and {Significance} within the {Bayesian} {Framework}},
        volume = {4},
        issn = {2475-9066},
        shorttitle = {{bayestestR}},
        url = {https://joss.theoj.org/papers/10.21105/joss.01541},
        doi = {10.21105/joss.01541},
        number = {40},
        urldate = {2019-08-13},
        journal = {Journal of Open Source Software},
        author = {Makowski, Dominique and Ben-Shachar, Mattan S. and Lüdecke, Daniel},
        month = aug,
        year = {2019},
        pages = {1541}
    }
    
    @article{makowski2020correlation,
      doi={10.21105/joss.02306},
      title={Methods and Algorithms for Correlation Analysis in R},
      author={Makowski, Dominique and Ben-Shachar, Mattan S. and Patil, Indrajeet and L{\"u}decke, Daniel},
      journal={Journal of Open Source Software},
      volume={5},
      number={51},
      pages={2306},
      year={2020}
    }
    
    @article{ludecke20202parameters,
      title = {parameters: Extracting, Computing and Exploring the Parameters of Statistical Models using {R}.},
      volume = {5},
      doi = {10.21105/joss.02445},
      number = {53},
      journal = {Journal of Open Source Software},
      author = {Daniel Lüdecke and Mattan S. Ben-Shachar and Indrajeet Patil and Dominique Makowski},
      year = {2020},
      pages = {2445},
    }
    
    @article{benchashar2020effectsize,
      title = {{e}ffectsize: Estimation of Effect Size Indices and Standardized Parameters},
      author = {Mattan S. Ben-Shachar and Daniel Lüdecke and Dominique Makowski},
      year = {2020},
      journal = {Journal of Open Source Software},
      volume = {5},
      number = {56},
      pages = {2815},
      publisher = {The Open Journal},
      doi = {10.21105/joss.02815},
      url = {https://doi.org/10.21105/joss.02815},
    }

</details>

## Versioning

Package version numbers indicate following:
`MAJOR.MINOR.PATCH.DEVELOPMENT`. As long as packages are in a more or
less rapidly developing and changing state, the **major** version number
is typically `0`. Once we think we will have a stable base that will
likely not change dramatically or soon, the major version number will be
set to `1`, and increased for following major changes that probably
break the current API. When new features are added or (re)moved, we
typically increase the **minor** version number. Minimal changes or bug
fixes only are indicated by increasing the **patch** version number.
Current development versions of our packages (i.e. master branch from
GitHub) additionally have a **development** version number. You
typically won’t find packages on CRAN with a development version number.

## Downloads

| Total     | insight   | bayestestR | parameters | performance | effectsize | correlation | see    | modelbased |
| :-------- | :-------- | :--------- | :--------- | :---------- | :--------- | :---------- | :----- | :--------- |
| 3,313,958 | 1,121,434 | 572,761    | 518,000    | 516,940     | 405,228    | 77,633      | 74,516 | 27,446     |

### Trend

<img src="man/figures/unnamed-chunk-7-1.png" style="display: block; margin: auto;" />

### Cumulative downloads

<img src="man/figures/unnamed-chunk-8-1.png" style="display: block; margin: auto;" />

<!-- ### Cyclic Trend -->

<!-- ```{r, message=FALSE, warning=FALSE, eval = TRUE, fig.align='center', echo=FALSE, dpi=300} -->

<!-- byweek <- lme4::lmer(count ~ day + (1|Package) + (1|month), data = data) %>%  -->

<!--   modelbased::estimate_means() %>%  -->

<!--   mutate(day = forcats::fct_relevel(as.factor(day), "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"), -->

<!--          average = mean(Mean), -->

<!--          x = as.numeric(day) / 7, -->

<!--          what="week", -->

<!--          month=NA) %>%  -->

<!--   arrange(day) -->

<!-- bymonth <- lme4::lmer(count ~ month + (1|Package) + (1|day), data = data) %>%  -->

<!--   modelbased::estimate_means() %>%  -->

<!--   mutate(month = forcats::fct_relevel(as.factor(month),  "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"), -->

<!--          average = mean(Mean), -->

<!--          x = as.numeric(month) / 12, -->

<!--          what="month", -->

<!--          day=NA) %>%  -->

<!--   arrange(month) -->

<!-- rbind(byweek, bymonth) %>%  -->

<!--   ggplot(aes(x=x, y=Mean, group = what, color=what)) + -->

<!--   geom_polygon(fill=NA, size=1) +  -->

<!--   geom_hline(yintercept = byweek$average[1], linetype="dotted") + -->

<!--   theme_modern() + -->

<!--   coord_polar(start=-pi/1.5) + -->

<!--   see::theme_radar() + -->

<!--   theme(axis.title.x = element_blank(), -->

<!--         axis.title.y = element_blank(), -->

<!--         axis.text.y = element_blank(), -->

<!--         panel.grid.major.y = element_blank()) -->

<!-- ``` -->

### Average monthly downloads

<img src="man/figures/unnamed-chunk-9-1.png" style="display: block; margin: auto;" />

## Convention of code-style

Following conventions apply to the easystats-ecosystem, to ensure that
function and argument names as well as element names for return-values
follow a consistent pattern across all packages.

**Importing other packages**

  - No full import, only selective import of functions

  - Use base-R wherever possible (reduce dependencies)

  - Make sure R-version requirements are not too strict

**Helper-functions**

  - Own re-implementation of helper-functions, if it’s not too much
    effort (e.g. I typically use own functions to check if a string
    starts / ends with a pattern, or if an object (list, data frame)
    contains an element with a given name (like `tibble::has_name()`),
    to reduce dependencies.

**`print` functions**

  - `print` methods should invisibly return the original (unchanged)
    input ([\#65](https://github.com/easystats/easystats/issues/65)).

**Function names**

  - Lower case, underscore separated if more than one verb.

  - Common prefix for functions that focus on specific “tasks” or
    workflows (e.g. **insight**, `get_*()` to get data, `find_*()` to
    find information, or **performance**, `performance_*()` to compute
    measures of model quality, `check_*()` to check model assumptions…).

  - Internal functions (that are not exported, like the previously
    mentioned helper-functions) should always start with a `.` (e.g.,
    `.do_some_internal_stuff()`).

**Argument names**

  - lower case, underscore separated if more than one verb

**Element / Column names** (for returned data frames)

1)  First letter of the column name is capital, unless (6) applies
    (*example:* `Parameter`).

2)  First letter of nouns is capital, unless (6) applies (*example:*
    `ROPE_Percentage`, `Prior_Scale`).

3)  Using underscore rather than camelCase to separate words (*example:*
    `CI_high`).

4)  Multiple words: common/main part first and
    adjective/specifier/variational part after, unless (8) applies
    (*example:* `Median_standardized`, `ROPE_percentage`).

5)  Abbreviations: all uppercase (*example:* `ESS`, `MCSE`, `ROPE`).

6)  Keep conventions for reserved words (*example:* `p`, `pd`, `Rhat`).

7)  Adjectives / verbs: all lower case, unless (1) applies (*example:*
    `high` or `low` in `CI_high` or `CI_low`).

8)  In case of multiple occurrences of column names that indicate the
    same measure or content (like `CI_low` or `SE`), the common part is
    appended as suffix to the context specific part (*example:* `CI_low`
    and `Eta2_partial_CI_low`, and **not** `CI_low` and
    `CI_low_Eta2_partial`).

9)  The “squared” term in column names that refers to “common”
    statistics (`Eta2`, `Chi2`, `Omega2`, …) should be written as `2`,
    not `sq`, `squared` or `pétit-deux` (*example:* `Chi2`, and **not**
    `Chisq`, `Eta2`, and **not** `Eta_squared`). This rule does **not**
    apply to function names.

## List of functions

<!-- ![](scripts/network_functions.png) -->

  - [**`add_plot_attributes`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`adjust`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`all_models_equal`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`all_models_same_class`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`area_under_curve`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`as.numeric_ifnumeric`**](https://easystats.github.io/modelbased/reference/index.html)
    *(modelbased)*
  - [**`auc`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`bayesfactor_inclusion`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`bayesfactor_models`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`bayesfactor_parameters`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`bayesfactor_pointnull`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`bayesfactor_restricted`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`bayesfactor_rope`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`bayesfactor`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`bayesian_as_frequentist`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`bf_inclusion`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`bf_models`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`bf_parameters`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`bf_pointnull`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`bf_restricted`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`bf_rope`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`binned_residuals`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`bluebrown_colors`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`bootstrap_model`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`bootstrap_parameters`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`center`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`change_scale`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`check_autocorrelation`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`check_clusterstructure`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`check_collinearity`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`check_convergence`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`check_distribution`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`check_factorstructure`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`check_heterogeneity`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`check_heteroscedasticity`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`check_homogeneity`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`check_itemscale`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`check_kmo`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`check_model`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`check_multimodal`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`check_normality`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`check_outliers`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`check_overdispersion`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`check_prior`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`check_singularity`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`check_sphericity`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`check_zeroinflation`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`chisq_to_cohens_w`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`chisq_to_cramers_v`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`chisq_to_phi`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`ci_betwithin`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`ci_kenward`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`ci_ml1`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`ci_robust`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`ci_satterthwaite`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`ci_wald`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`ci`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`clean_names`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`clean_parameters`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`cliffs_delta`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`closest_component`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`cluster_analysis`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`cluster_discrimination`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`cohens_d`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`cohens_f_squared`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`cohens_f`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`cohens_g`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`cohens_h`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`cohens_w`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`color_if`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`colour_if`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`compare_models`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`compare_parameters`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`compare_performance`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`contr.bayes`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`convert_bayesian_as_frequentist`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`convert_d_to_common_language`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`convert_d_to_odds`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`convert_d_to_oddsratio`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`convert_d_to_r`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`convert_data_to_numeric`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`convert_efa_to_cfa`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`convert_odds_to_d`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`convert_odds_to_probs`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`convert_odds_to_r`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`convert_oddsratio_to_d`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`convert_oddsratio_to_r`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`convert_p_to_pd`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`convert_pd_to_p`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`convert_probs_to_odds`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`convert_r_to_d`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`convert_r_to_odds`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`convert_r_to_oddsratio`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`coord_radar`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`cor_test`**](https://easystats.github.io/correlation/reference/index.html)
    *(correlation)*
  - [**`cor_to_ci`**](https://easystats.github.io/correlation/reference/index.html)
    *(correlation)*
  - [**`cor_to_cov`**](https://easystats.github.io/correlation/reference/index.html)
    *(correlation)*
  - [**`cor_to_p`**](https://easystats.github.io/correlation/reference/index.html)
    *(correlation)*
  - [**`cor_to_pcor`**](https://easystats.github.io/correlation/reference/index.html)
    *(correlation)*
  - [**`cor_to_spcor`**](https://easystats.github.io/correlation/reference/index.html)
    *(correlation)*
  - [**`correlation`**](https://easystats.github.io/correlation/reference/index.html)
    *(correlation)*
  - [**`cramers_v`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`cronbachs_alpha`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`d_to_common_language`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`d_to_odds`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`d_to_oddsratio`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`d_to_r`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`data_adjust`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`data_partition`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`data_plot`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`data_to_numeric`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`degrees_of_freedom`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`degroup`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`demean`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`density_at`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`describe_distribution`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`describe_posterior`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`describe_prior`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`detrend`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`diagnostic_posterior`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`display`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`distance_mahalanobis`**](https://easystats.github.io/correlation/reference/index.html)
    *(correlation)*
  - [**`distribution_beta`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`distribution_binomial`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`distribution_cauchy`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`distribution_chisquared`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`distribution_custom`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`distribution_gamma`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`distribution_mixture_normal`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`distribution_nbinom`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`distribution_normal`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`distribution_poisson`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`distribution_student`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`distribution_tweedie`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`distribution_uniform`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`distribution`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`dof_betwithin`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`dof_kenward`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`dof_ml1`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`dof_satterthwaite`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`dof`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`download_model`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`efa_to_cfa`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`effective_sample`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`effectsize`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`ellipsis_info`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`epsilon_squared`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`equivalence_test`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`estimate_contrasts`**](https://easystats.github.io/modelbased/reference/index.html)
    *(modelbased)*
  - [**`estimate_density`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`estimate_link`**](https://easystats.github.io/modelbased/reference/index.html)
    *(modelbased)*
  - [**`estimate_means`**](https://easystats.github.io/modelbased/reference/index.html)
    *(modelbased)*
  - [**`estimate_response`**](https://easystats.github.io/modelbased/reference/index.html)
    *(modelbased)*
  - [**`estimate_slopes`**](https://easystats.github.io/modelbased/reference/index.html)
    *(modelbased)*
  - [**`estimate_smooth`**](https://easystats.github.io/modelbased/reference/index.html)
    *(modelbased)*
  - [**`eta_squared_posterior`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`eta_squared`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`eta2_to_f`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`eta2_to_f2`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`eti`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`export_table`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`F_to_d`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`F_to_epsilon2`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`F_to_eta2_adj`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`f_to_eta2`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`F_to_eta2`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`F_to_f`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`F_to_f2`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`F_to_omega2`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`F_to_r`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`f2_to_eta2`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`factor_analysis`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`find_algorithm`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`find_formula`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`find_interactions`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`find_inversions`**](https://easystats.github.io/modelbased/reference/index.html)
    *(modelbased)*
  - [**`find_offset`**](https://easystats.github.io/insight/reference/index.html)
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
  - [**`find_smooth`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`find_statistic`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`find_terms`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`find_variables`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`find_weights`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`flat_colors`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`format_bf`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`format_ci`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`format_number`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`format_order`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`format_p_adjust`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`format_p`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`format_parameters`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`format_pd`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`format_rope`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`format_standardize`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`format_table`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`format_value`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`geom_count_borderless`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`geom_count2`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`geom_jitter_borderless`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`geom_jitter2`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`geom_point_borderless`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`geom_point2`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`geom_pointrange_borderless`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`geom_pointrange2`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`geom_pooljitter`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`geom_poolpoint`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`geom_violindot`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`geom_violinhalf`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`get_auxiliary`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`get_call`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`get_correlation_slope_intercept`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`get_data`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`get_deviance`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`get_df`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`get_effectsize_label`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`get_intercept`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`get_loglikelihood`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`get_parameters`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`get_predicted`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`get_predictors`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`get_priors`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`get_random`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`get_residuals`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`get_response`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`get_scores`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`get_sigma`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`get_statistic`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`get_varcov`**](https://easystats.github.io/insight/reference/index.html)
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
  - [**`get_weights`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`glass_delta`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`golden_ratio`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`has_intercept`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`hdi`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`hedges_g`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`icc`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`interpret_agfi`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`interpret_bf`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`interpret_cfi`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`interpret_d`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`interpret_delta`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`interpret_direction`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`interpret_epsilon_squared`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`interpret_ess`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`interpret_eta_squared`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`interpret_g`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`interpret_gfi`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`interpret_ifi`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`interpret_kendalls_w`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`interpret_nfi`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`interpret_nnfi`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`interpret_odds`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`interpret_oddsratio`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`interpret_omega_squared`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`interpret_p`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`interpret_parameters`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`interpret_pnfi`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`interpret_r`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`interpret_r2`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`interpret_rfi`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`interpret_rhat`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`interpret_rmsea`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`interpret_rope`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`interpret_srmr`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`interpret`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`is_effectsize_name`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`is_mixed_model`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`is_model_supported`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`is_model`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`is_multivariate`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`is_nested_models`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`is_nullmodel`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`is_regression_model`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`is.cor`**](https://easystats.github.io/correlation/reference/index.html)
    *(correlation)*
  - [**`is.rules`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`isSquare`**](https://easystats.github.io/correlation/reference/index.html)
    *(correlation)*
  - [**`item_difficulty`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`item_intercor`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`item_reliability`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`item_split_half`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`kendalls_w`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`kurtosis`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`link_function`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`link_inverse`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`loglikelihood`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`logodds_to_d`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`logodds_to_r`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`logoddsratio_to_d`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`logoddsratio_to_r`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`looic`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`mad_pooled`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`map_estimate`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`material_colors`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`matrix_inverse`**](https://easystats.github.io/correlation/reference/index.html)
    *(correlation)*
  - [**`mcse`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`mediation`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`metro_colors`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`mhdior`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`model_info`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`model_name`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`model_parameters`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`model_performance`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`mse`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`multicollinearity`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`n_clusters`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`n_components`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`n_factors`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`n_obs`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`n_parameters`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`normalize`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`null_model`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`odds_to_d`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`odds_to_probs`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`odds_to_r`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`oddsratio_to_d`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`oddsratio_to_r`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`oddsratio_to_riskratio`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`oddsratio`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`omega_squared`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`overlap`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`p_direction`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`p_map`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`p_pointnull`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`p_rope`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`p_significance`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`p_to_pd`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`p_value_betwithin`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`p_value_kenward`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`p_value_ml1`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`p_value_robust`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`p_value_satterthwaite`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`p_value_wald`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`p_value`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`palette_bluebrown`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`palette_flat`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`palette_material`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`palette_metro`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`palette_pizza`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`palette_see`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`palette_social`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`parameters_table`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`parameters_type`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`parameters`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`pcor_to_cor`**](https://easystats.github.io/correlation/reference/index.html)
    *(correlation)*
  - [**`pd_to_p`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`pd`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`performance_accuracy`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`performance_aic`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`performance_aicc`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`performance_hosmer`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`performance_logloss`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`performance_lrt`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`performance_mse`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`performance_pcp`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`performance_rmse`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`performance_roc`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`performance_rse`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`performance_score`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`performance`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`phi_to_chisq`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`phi`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`pizza_colors`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`plots`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`point_estimate`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`pool_parameters`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`posterior_predictive_check`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`pp_check`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`principal_components`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`print_color`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`print_colour`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`print_html`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`print_md`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`print_parameters`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`probs_to_odds`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`r_to_d`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`r_to_odds`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`r_to_oddsratio`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`r2_bayes`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`r2_coxsnell`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`r2_efron`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`r2_kullback`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`r2_loo`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`r2_mcfadden`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`r2_mckelvey`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`r2_nagelkerke`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`r2_nakagawa`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`r2_posterior`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`r2_somers`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`r2_tjur`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`r2_xu`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`r2_zeroinflated`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`r2`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`random_parameters`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`rank_biserial`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`rank_epsilon_squared`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`ranktransform`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`reduce_data`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`reduce_parameters`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`rescale_weights`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`reshape_ci`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`reshape_draws`**](https://easystats.github.io/modelbased/reference/index.html)
    *(modelbased)*
  - [**`reshape_loadings`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`riskratio_to_oddsratio`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`riskratio`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`rmse`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`rnorm_perfect`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`rope_range`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`rope`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`rotated_data`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`rules`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`scale_color_bluebrown_c`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_color_bluebrown_d`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_color_bluebrown`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_color_flat_c`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_color_flat_d`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_color_flat`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_color_material_c`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_color_material_d`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_color_material`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_color_metro_c`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_color_metro_d`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_color_metro`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_color_pizza_c`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_color_pizza_d`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_color_pizza`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_color_see_c`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_color_see_d`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_color_see`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_color_social_c`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_color_social_d`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_color_social`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_colour_bluebrown_c`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_colour_bluebrown_d`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_colour_bluebrown`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_colour_flat_c`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_colour_flat_d`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_colour_flat`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_colour_material_c`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_colour_material_d`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_colour_material`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_colour_metro_c`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_colour_metro_d`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_colour_metro`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_colour_pizza_c`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_colour_pizza_d`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_colour_pizza`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_colour_see_c`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_colour_see_d`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_colour_see`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_colour_social_c`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_colour_social_d`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_colour_social`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_fill_bluebrown_c`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_fill_bluebrown_d`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_fill_bluebrown`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_fill_flat_c`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_fill_flat_d`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_fill_flat`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_fill_material_c`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_fill_material_d`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_fill_material`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_fill_metro_c`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_fill_metro_d`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_fill_metro`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_fill_pizza_c`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_fill_pizza_d`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_fill_pizza`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_fill_see_c`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_fill_see_d`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_fill_see`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_fill_social_c`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_fill_social_d`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`scale_fill_social`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`sd_pooled`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`se_betwithin`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`se_kenward`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`se_ml1`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`se_satterthwaite`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`see_colors`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`select_parameters`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`sensitivity_to_prior`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`sexit_thresholds`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`sexit`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`si`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`simulate_correlation`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`simulate_difference`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`simulate_model`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`simulate_parameters`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`simulate_prior`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`simulate_simpson`**](https://easystats.github.io/correlation/reference/index.html)
    *(correlation)*
  - [**`simulate_ttest`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`skewness`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`smoothing`**](https://easystats.github.io/modelbased/reference/index.html)
    *(modelbased)*
  - [**`smoothness`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`social_colors`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`standard_error_robust`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`standard_error`**](https://easystats.github.io/parameters/reference/index.html)
    *(parameters)*
  - [**`standardize_info`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`standardize_names`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`standardize_parameters`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`standardize_posteriors`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`standardize`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`supported_models`**](https://easystats.github.io/insight/reference/index.html)
    *(insight)*
  - [**`t_to_d`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`t_to_epsilon2`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`t_to_eta2_adj`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`t_to_eta2`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`t_to_f`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`t_to_f2`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`t_to_omega2`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`t_to_r`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`test_bf`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`test_likelihoodratio`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`test_performance`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`test_vuong`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`test_wald`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`theme_abyss`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`theme_blackboard`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`theme_lucid`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`theme_modern`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`theme_radar_dark`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`theme_radar`**](https://easystats.github.io/see/reference/index.html)
    *(see)*
  - [**`unstandardize`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`unupdate`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`variance_decomposition`**](https://easystats.github.io/performance/reference/index.html)
    *(performance)*
  - [**`visualisation_matrix`**](https://easystats.github.io/modelbased/reference/index.html)
    *(modelbased)*
  - [**`weighted_posteriors`**](https://easystats.github.io/bayestestR/reference/index.html)
    *(bayestestR)*
  - [**`winsorize`**](https://easystats.github.io/correlation/reference/index.html)
    *(correlation)*
  - [**`z_fisher`**](https://easystats.github.io/correlation/reference/index.html)
    *(correlation)*
  - [**`z_to_d`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`z_to_r`**](https://easystats.github.io/effectsize/reference/index.html)
    *(effectsize)*
  - [**`zero_crossings`**](https://easystats.github.io/modelbased/reference/index.html)
    *(modelbased)*
