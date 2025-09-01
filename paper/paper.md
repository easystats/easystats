---
title: "Welcome to the easystats"
tags:
  - R
authors:
- affiliation: 1
  name: Daniel Lüdecke
  orcid: 0000-0002-8895-3206
- affiliation: 2
  name: Mattan S. Ben-Shachar
  orcid: 0000-0002-4287-4801
- affiliation: 3
  name: Indrajeet Patil
  orcid: 0000-0003-1995-6531
- affiliation: 4
  name: Brenton M. Wiernik
  orcid: 0000-0001-9560-6336
- affiliation: 5
  name: Etienne Bacher
  orcid: 0000-0002-9271-5075
- affiliation: 6
  name: Rémi Thériault
  orcid: 0000-0003-4315-6788
- affiliation: "7, 8"
  name: Dominique Makowski
  orcid: 0000-0001-5375-9967
affiliations:
- index: 1
  name:  University Medical Center Hamburg-Eppendorf, Germany
- index: 2
  name: Independent Researcher, Ramat Gan, Israel
- index: 3
  name: Carl Zeiss AG, Germany
- index: 4
  name: Independent Researcher, Tampa, FL, USA
- index: 5
  name: Luxembourg Institute of Socio-Economic Research (LISER), Luxembourg
- index: 6
  name: Department of Psychology, New York University, New York, NY, USA
- index: 7
  name: School of Psychology, University of Sussex, Brighton, UK
- index: 8
  name: Sussex Centre for Consciousness Science, University of Sussex, Brighton, UK
type: article
date: "2025-09-01"
bibliography: paper.bib
# abstract: |
# Todo
keywords: |
  R; easystats
acknowledgement: |
  *{easystats}* is part of the collaborative
  [*easystats*](https://github.com/easystats/easystats) ecosystem
  [@easystatspackage]. Thus, we thank all
  [members of easystats](https://github.com/orgs/easystats/people),
  contributors, and users alike.
authorcontributions: |
  D.L. and D.M. drafted the paper; all authors contributed to both the
  writing of the paper and the conception of the software.
funding: |
  This research received no external funding.
conflictsofinterest: |
  The authors declare no conflict of interest.
output:
  rticles::joss_article
journal:
  pissn: 2475-9066
csl: apa.csl
---



# Summary

The **easystats** project is a collection of R packages that provides a unified and intuitive framework for statistical analysis. The ecosystem is built around a "tidyverse-like" philosophy of consistency, user-friendliness, and interoperability between packages. It aims to simplify the process of preparing, conducting, interpreting, and reporting statistical analyses by offering tools for a wide range of common tasks. These tasks include, for instance, data wrangling (`{datawizard}`), model assessment [`{performance}`, @Lüdecke2020performance], understanding and describing model parameters [`{parameters}`, @Lüdecke2020parameters], including Bayesian models [`{bayestestR}`, @Makowski2019], computation of effect sizes [`{effectsize}`, @Ben-Shachar2020], calculating and visualizing marginal effects [`{modelbased}`, @Makowski2025modelbased], and generating publication-ready figures [`{see}`, @ludecke_see_2021] or reports of statistical models (`{report}`). The **easystats** ecosystem is designed to be accessible to both novice and experienced R users, promoting reproducible research and a more seamless workflow from data exploration to result communication.

# Statement of Need

The R programming language is a powerful and dominant tool for statistical computing in academic research. However, its power is distributed across a vast and fragmented ecosystem of packages. For a researcher to conduct a comprehensive statistical analysis—from fitting a model to checking its assumptions, interpreting its parameters, and visualizing the results—they often need to learn and combine numerous packages, each with its own unique syntax, design principles, and output structures. This fragmentation presents a significant barrier to entry for new users and creates an inefficient and often confusing workflow for even experienced analysts.

The **easystats** ecosystem was developed to address this challenge by providing a unified, consistent, and intuitive framework for data wrangling, data exploration, statistical summaries and modeling, visualization, and reporting in R. Its primary goal is to make a robust and transparent statistical analysis more accessible to a broad range of users, from students to seasoned researchers. **easystats** achieves this through a suite of lightweight, interoperable, and modular packages, each designed to handle a specific stage of the statistical workflow. Because these packages share a consistent syntax and work seamlessly together, they dramatically lower the cognitive load required to conduct such analytical workflows.

While other software toolkits exist, they often serve different purposes. The `{tidyverse}` [@Wickham2019], for example, provides a world-class environment for data manipulation and general-purpose plotting but does not focus on the intricacies of statistical model interpretation and reporting. Specialist packages like `{lme4}` [@bates_fitting_2015] for mixed-effects models or `{marginaleffects}` [@arel-bundock_how_2024] for marginal means are essential tools, but **easystats** serves as a complementary "meta-layer" that provides a single, easy-to-learn interface for interacting with the outputs from these and many other modeling packages. This allows researchers to focus on their scientific questions rather than on the technical idiosyncrasies of different software implementations.

Ultimately, **easystats** fills a critical need in the R ecosystem for a user-friendly and cohesive suite of tools dedicated to the statistical modeling pipeline.

# A Harmonized and Integrated Workflow

A key design principle of the **easystats** ecosystem is the harmonization and integration of different packages into a simple, sequential workflow. The typical workflow for a statistical analysis using `{easystats}` starts with fitting a model, and then sequentially using different functions to obtain a comprehensive understanding of the model.

It is worth noting that instead of loading each package separately, it is also possible to load all the core **easystats** packages in one go by loading the meta-package `{easystats}`.

Let's demonstrate this with an example, where the user might start by preparing some data and fitting a simple linear model:


``` r
library(easystats)
data(coffee_data, package = "modelbased")

# dichotomize outcome variable
coffee_data$alertness <- categorize(coffee_data$alertness, lowest = 0)

# rename variable
coffee_data <- data_rename(coffee_data, select = c(treatment = "coffee"))

# fit model
model <- glm(
  alertness ~ treatment,
  data = coffee_data,
  family = binomial()
)
```

The `model` object can then be passed to functions from different **easystats** packages. For instance, the user can get a summary of the model parameters using the `{parameters}` package:


``` r
model_parameters(model)
#> Parameter           | Log-Odds |   SE |        95% CI |     z |     p
#> ---------------------------------------------------------------------
#> (Intercept)         |     0.13 | 0.26 | [-0.37, 0.65] |  0.52 | 0.606
#> treatment [control] |    -0.27 | 0.37 | [-0.99, 0.45] | -0.73 | 0.466
```

Then, the performance of the model can be assessed with the `{performance}` package:


``` r
model_performance(
  model,
  metrics = c("AIC", "BIC", "R2", "PCP")
)
#> # Indices of model performance
#> 
#> AIC   |   BIC | Tjur's R2 |   PCP
#> ---------------------------------
#> 169.8 | 175.4 |     0.004 | 0.502
```

The results can be visualized using the `{see}` package, for example by plotting the model's predictions with `{modelbased}`:


``` r
predictions <- estimate_means(model, "treatment")
plot(predictions)
```


\includegraphics[width=1\linewidth]{paper_files/figure-latex/unnamed-chunk-5-1} 

Finally, a full report of the analysis can be generated with the `{report}` package:


``` r
report(model)
#> We fitted a logistic model (estimated using ML) to predict alertness with
#> treatment (formula: alertness ~ treatment). The model's explanatory power is
#> very weak (Tjur's R2 = 4.44e-03). The model's intercept, corresponding to
#> treatment = coffee, is at 0.13 (95% CI [-0.37, 0.65], p = 0.606). Within this
#> model:
#> 
#>   - The effect of treatment [control] is statistically non-significant and
#> negative (beta = -0.27, 95% CI [-0.99, 0.45], p = 0.466; Std. beta = -0.27, 95%
#> CI [-0.99, 0.45])
#> 
#> Standardized parameters were obtained by fitting the model on a standardized
#> version of the dataset. 95% Confidence Intervals (CIs) and p-values were
#> computed using a Wald z-distribution approximation.
```

This seamless integration between packages allows users to move from model fitting to interpretation and reporting in a fluid and intuitive manner, without having to learn different syntaxes or data structures.

# Licensing and Availability

`{easystats}` is licensed under the MIT-License, with all source code stored at GitHub (<https://github.com/easystats/easystats>), and with a corresponding issue tracker for bug reporting and feature enhancements. In the spirit of honest and open science, we encourage requests, tips for fixes, feature updates, as well as general questions and concerns via direct interaction with contributors and developers.

# Acknowledgments

`{easystats}` is part of the collaborative **easystats** ecosystem [@easystatspackage]. Thus, we thank all [members of easystats](https://github.com/orgs/easystats/people), contributors, and users alike.

# References
