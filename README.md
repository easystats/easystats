
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

# What is *easystats*?

**easystats** is a collection of R packages, which aims to provide a
unifying and consistent framework to tame, discipline, and harness the
scary R statistics and their pesky models.

However, there is not (yet) an *unique* “easystats” way of doing data
analysis. Instead, start with one package and, when you’ll face a new
challenge, do check if there is an *easystats* answer for it in other
packages. You will slowly uncover how using them together facilitates
your life. And, who knows, you might even end up using them all.
***Gotta catch ’em all\!*** <!--
'tis a pokémon reference for y'all grandpas -->

# Getting started

Each **easystats** package has a different scope and purpose. This means
your **best way to start** is to explore and pick the one(s) that you
feel might be useful to you. However, as they are built with a “bigger
picture” in mind, you will realize that using more of them creates a
smooth workflow, as these packages are meant to work together. Ideally,
these packages work in unison to cover all aspects of statistical
analysis and data visualization.

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

# Frequently Asked Questions

**How is *easystats* different from the *tidyverse*?**

You’ve probably already heard about the
[**tidyverse**](https://www.tidyverse.org/), another very popular
collection of packages (*ggplot*, *dplyr*, *tidyr*, …) that also makes
using R easier. So, should you pick the *tidyverse* or *easystats*?
**Pick both\!**

Indeed, these two ecosystems have been designed with very different
goals in mind. The *tidyverse* packages are primarily made to create a
new R experience, where data manipulation and exploration is intuitive
and consistent. On the other hand, **easystats** focuses more on the
final stretch of the analysis: understanding and interpreting your
results and reporting them in a manuscript or a report, while following
best practices. You can definitely use the *easystats* functions in a
*tidyverse* workflow\!

> **easystats + tidyverse =** ❤️

**Can *easystats* be useful to advanced users and/or developers?**

Yes, definitely\! **easystats** is built in terms of modules that are
general enough to be used inside other packages. For instance, the
*insight* package is made to easily implement support for
post-processing of pretty much all regression model packages under the
sun. We use it in all the *easystats* packages, but it also used for
instance in
[**ggstatsplot**](https://github.com/IndrajeetPatil/ggstatsplot),
[**ggeffects**](https://github.com/strengejacke/ggeffects), and more.

**So why not in yours**?

Moreover, the *easystats* packages are very lightweight, with a minimal
set of dependencies, which again makes it great if you want to rely on
them.

# Installation

The whole `easystats` suite can be installed *at once* with the
following:

``` r
install.packages("remotes")
remotes::install_github("easystats/easystats")
```

You can then load the entire ecosystem by running:

``` r
library("easystats")
```

# Documentation

## Websites

Each `easystats` package has a dedicated website.

For example, website for `parameters` is
<https://easystats.github.io/parameters/>.

## Blog

In addition to the websites containing documentation for these packages,
you can also read posts from `easystats` blog:
<https://easystats.github.io/blog/posts/>.

## Other learning resources

In addition to these websites and blog posts, you can also check out the
following presentations and talks to learn more about this ecosystem:

<https://easystats.github.io/easystats/articles/resources.html>

# Dependencies

Most *easystats* packages are very lightweight, *i.e.*, they don’t rely
nor import any other packages\! This means that you can safely use them
as dependencies in your own packages, without the risk of a butterfly
effect, where a small change in a distant downstream dependency with
unexpected upstream consequences.

For example, the `parameters` package only relies on two other packages.

![](man/figures/depnetwork_parameters-1.png)<!-- -->

<!-- TODO: uncomment once on CRAN -->

<!-- ```{r depnetwork_easystats} -->

<!-- library(deepdep) -->

<!-- plot_dependencies("easystats", depth = 3) -->

<!-- ``` -->

**There is one exception**\!

The [**see**](http://easystats.github.io/see) package is one of our
high-level packages that is responsible for plotting and creating
figures, relying thus on other packages such as *ggplot2*, which has a
substantial number of dependencies.

![](man/figures/depnetwork_see-1.png)<!-- -->

# Citation

How to reference *easystats*?

1.  **Cite specific packages**

The most parsimonious approach is to cite only the particular package
that helped you, e.g.,

> “using *bayestestR* (Makowski, Ben-Shachar, & Lüdecke, 2019)”.

2.  **Cite the whole ecosystem** :heart:

Want to credit the whole *easystats* ecosystem of packages?

This can be done with a sentence like the following:

> Data processing was carried out with R (R Core Team, 2019) and the
> *easystats* ecosystem (Lüdecke, Waggoner, & Makowski, 2019; Lüdecke,
> Ben-Shachar, Patil, Waggoner, & Makowski, 2021; Makowski, Ben-Shachar,
> & Lüdecke, 2019; Makowski, Ben-Shachar, Patil, & Lüdecke, 2020;
> Lüdecke, Ben-Shachar, Patil, & Makowski, 2020; Ben-Shachar, Lüdecke,
> & Makowski, 2020)

  - Lüdecke, D., Waggoner, P. D., & Makowski, D. (2019). insight: A
    Unified Interface to Access Information from Model Objects in R.
    *Journal of Open Source Software*, *4*, 1412.
    <https://doi.org/10.21105/joss.01412>

  - Makowski, D., Ben-Shachar, M.S., & Lüdecke, D. (2019). bayestestR:
    Describing Effects and their Uncertainty, Existence and Significance
    within the Bayesian Framework. *Journal of Open Source Software*,
    *4*(40), 1541. <https://doi.org/10.21105/joss.01541>

  - Makowski, D., Ben-Shachar, M.S., Patil, I., & Lüdecke, D. (2019).
    Methods and Algorithms for Correlation Analysis in R. *Journal of
    Open Source Software*, *5*(51), 2306.
    <https://doi.org/10.21105/joss.02306>

  - Lüdecke, D., Ben-Shachar, M.S., Patil, I., & Makowski, D. (2020).
    parameters: Extracting, Computing and Exploring the Parameters of
    Statistical Models using R. *Journal of Open Source Software*,
    *5*(53), 2445. <https://doi.org/10.21105/joss.02445>

  - Ben-Shachar, M.S., Lüdecke, D., Makowski, D. (2020). effectsize:
    Estimation of Effect Size Indices and Standardized Parameters.
    *Journal of Open Source Software*, *5*(56), 2815.
    <https://doi.org/10.21105/joss.02815>

  - Lüdecke, D., Ben-Shachar, M.S., Patil, I., Waggoner, P. D., &
    Makowski, D. (2021). performance: An R Package for Assessment,
    Comparison and Testing of Statistical Models. *Journal of Open
    Source Software*, *6*(60), 3139.
    <https://doi.org/10.21105/joss.03139>

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
    
    @Article{Lüdecke2021performance,
        title = {{performance}: An {R} Package for Assessment, Comparison and Testing of Statistical Models},
        author = {Daniel Lüdecke and Mattan S. Ben-Shachar and Indrajeet Patil and Philip Waggoner and Dominique Makowski},
        year = {2021},
        journal = {Journal of Open Source Software},
        volume = {6},
        number = {60},
        pages = {3139},
        doi = {10.21105/joss.03139},
      }

</details>

# Versioning

Package version numbers indicate following:
`MAJOR.MINOR.PATCH.DEVELOPMENT`. Here are key steps to keep in mind:

  - As long as packages are in a more or less rapidly developing and
    changing state, the **major** version number is typically `0`.

  - Once we think we will have a stable base that will likely not change
    dramatically or soon, the major version number will be set to `1`,
    and will be increased for following major changes that probably
    break the current API.

  - When new features are added or (re)moved, we typically increase the
    **minor** version number.

  - Minimal changes or bug fixes only are indicated by increasing the
    **patch** version number.

  - Current development versions of our packages (i.e. master/main
    branch from GitHub) additionally have a **development** version
    number.

# Downloads

| Total     | insight   | bayestestR | parameters | performance | effectsize | correlation | see    | modelbased | report |
| :-------- | :-------- | :--------- | :--------- | :---------- | :--------- | :---------- | :----- | :--------- | :----- |
| 3,950,902 | 1,326,619 | 671,277    | 618,253    | 605,802     | 492,131    | 102,661     | 93,862 | 36,782     | 3,515  |

### Trend

<img src="man/figures/unnamed-chunk-5-1.png" style="display: block; margin: auto;" />

### Cumulative downloads

<img src="man/figures/unnamed-chunk-6-1.png" style="display: block; margin: auto;" />

### Average monthly downloads

<img src="man/figures/unnamed-chunk-7-1.png" style="display: block; margin: auto;" />

# Contributing

We are happy to receive bug reports, suggestions, questions, and (most
of all) contributions to fix problems and add features. Pull Requests
for contributions are encouraged.

Here are some simple ways in which you can contribute (in the increasing
order of commitment):

  - Read and correct any inconsistencies in the documentation

  - Raise issues about bugs or wanted features

  - Review code

  - Add new functionality

# Code of Conduct

Please note that the ‘easystats’ project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
