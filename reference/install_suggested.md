# Download all suggested packages

In `easystats`, we have a 0-dependency policy, which makes our packages
fairly light and fast to install. However, we rely on many many (many)
packages for testing (at least all the packages for functions that we
support) and some specific features. These "soft dependencies" can be
downloaded at once using this function. This will allow you to fully
utilize all of easystats' functionalities without errors.

## Usage

``` r
install_suggested(package = "easystats")

show_suggested(package = "easystats")

show_reverse_dependencies(package = "easystats")
```

## Arguments

- package:

  If `NULL` or `"easystats"` (the default), all suggested packages for
  all 'easystats' packages will be installed. If specific packages are
  specified, only suggested packages for those packages will be
  installed.

## Value

Useful only for its side-effect of installing the needed packages.

## Details

To reduce the dependency load, 'easystats' packages by default will not
download all internally needed packages. It will ask the user to
download them only if they are needed. The current function can help
install all packages a given 'easystats' package might need. For
example, `install_suggested("see")`. `show_suggested()` is a convenient
helper to show the current list of suggested packages for each
'easystats' package.

If package `{pak}` is installed,
[`pak::pkg_install()`](https://pak.r-lib.org/reference/pkg_install.html)
will be used to install packages. Else,
[`utils::install.packages()`](https://rdrr.io/r/utils/install.packages.html)
is used.

## Examples

``` r
# download all suggested packages
if (FALSE) {
  install_suggested("easystats")
}

# listing all reverse dependencies of easystats packages
show_reverse_dependencies()
#> bayestestR
#> ----------
#> BaHZING, bayesMeanScale, brmsmargins, clinicalsignificance, correlation,
#>   easystats, eDNAjoint, effectsize, fbst, GCEstim, LoTTA, modelbased,
#>   movedesign, multifear, neatStats, parameters, pcvr, performance, psycho,
#>   report, rstanbdp, see, sjPlot, snSMART, SSVS, statsExpressions,
#>   survregVB
#> 
#> correlation
#> -----------
#> AssumpSure, easystats, ggstatsplot, multitool, popstudy, see,
#>   statsExpressions, TangledFeatures
#> 
#> datawizard
#> ----------
#> bayestestR, correlation, easystats, effectsize, ggeffects, ggstatsplot,
#>   modelbased, parameters, performance, report, see, sjlabelled, sjmisc,
#>   sjPlot, sjstats, statsExpressions
#> 
#> effectsize
#> ----------
#> apa7, AssumpSure, bruceR, easystats, markeR, multifear, psycho, report,
#>   see, sjstats, statdecideR, statsExpressions, suRface.analytics, visvow,
#>   volker
#> 
#> insight
#> -------
#> aggreCAT, ale, BayesMoFo, bayestestR, bregr, bsitar, candisc, clarify,
#>   clinicalsignificance, correlation, cv, datawizard, DImodelsVis,
#>   easystats, EcoMetrics, effects, effectsize, ggDoE, ggeffects,
#>   ggstatsplot, insurancerating, lavaanExtra, marginaleffects, modelbased,
#>   modelsummary, multiScaleR, MuMIn, mvgam, ordbetareg, parameters,
#>   performance, pminternal, psycho, randomizeR, regressinator, report, see,
#>   SimplyAgree, sjlabelled, sjmisc, sjPlot, sjstats, statsExpressions,
#>   tidygam, tinyVAST
#> 
#> modelbased
#> ----------
#> AssumpSure, easystats, see
#> 
#> parameters
#> ----------
#> apa7, clintools, correlation, cvms, dotwhisker, easystats, effectsize,
#>   EMOTIONS, ggstatsplot, MCM, modelbased, modelsummary, multitool, peramo,
#>   psycho, regport, report, see, sjPlot, sjstats, statsExpressions,
#>   StroupGLMM
#> 
#> performance
#> -----------
#> apa7, AssumpSure, CR2, dotwhisker, easystats, effectsize, ggstatsplot,
#>   MDMA, MLMusingR, modelsummary, multitool, piecewiseSEM, PLSDAbatch,
#>   pubh, report, SCDA, see, sjPlot, sjstats, statsExpressions,
#>   steppedwedge, SynergyLMM, ZLAvian
#> 
#> report
#> ------
#> easystats, SqueakR
#> 
#> see
#> ---
#> AssumpSure, easystats, jsmodule
#> 

# listing all soft/weak dependencies of easystats packages
show_suggested()
#> bayestestR
#> ----------
#> BayesFactor, bayesQR, bayesplot, betareg, BH, blavaan, bridgesampling,
#>   brms, collapse, curl, effectsize, emmeans, gamm4, ggdist, ggplot2,
#>   glmmTMB, httr2, KernSmooth, knitr, lavaan, lme4, logspline,
#>   marginaleffects, MASS, mclust, mediation, modelbased, ordbetareg,
#>   parameters, patchwork, performance, posterior, quadprog, RcppEigen,
#>   rmarkdown, rstan, rstanarm, see, testthat, tinytable, tweedie, withr
#> 
#> correlation
#> -----------
#> BayesFactor, energy, ggplot2, ggraph, gt, Hmisc, knitr, lme4, MASS,
#>   mbend, polycor, poorman, ppcor, psych, rmarkdown, rmcorr, rstanarm, see,
#>   testthat, tidygraph, wdm, WRS2, openxlsx2
#> 
#> datawizard
#> ----------
#> bayestestR, boot, BH, brms, curl, data.table, dplyr, effectsize,
#>   emmeans, gamm4, ggplot2, gt, haven, httr, knitr, lme4, mediation,
#>   modelbased, nanoparquet, parameters, performance, poorman, psych,
#>   readxl, readr, rio, rmarkdown, rstanarm, see, testthat, tibble, tidyr,
#>   tinytable, withr
#> 
#> effectsize
#> ----------
#> correlation, see, afex, BayesFactor, boot, brms, car, emmeans, gt,
#>   knitr, lavaan, lme4, lmerTest, mgcv, parsnip, pwr, rmarkdown, rms,
#>   rstanarm, rstantools, testthat
#> 
#> insight
#> -------
#> AER, afex, aod, ape, BayesFactor, bayestestR, bbmle, bdsmatrix, betareg,
#>   biglm, BH, blavaan, blme, boot, brms, broom, car, carData, censReg,
#>   cgam, clubSandwich, cobalt, coxme, cplm, crch, curl, datawizard, dbarts,
#>   effectsize, emmeans, epiR, estimatr, feisr, fixest, fungible, fwb, gam,
#>   gamlss, gamlss.data, gamm4, gbm, gee, geepack, geoR, GLMMadaptive,
#>   glmmTMB, glmtoolbox, gmnl, grDevices, gt, httptest2, httr2, interp,
#>   ivreg, JM, knitr, lavaan, lavaSearch2, lcmm, lfe, lme4, lmerTest,
#>   lmtest, logistf, logitr, marginaleffects, MASS, Matrix, mclogit, mclust,
#>   MCMCglmm, merTools, metaBMA, metadat, metafor, metaplus, mgcv, mhurdle,
#>   mice, mlogit, mmrm, modelbased, multgee, MuMIn, mvtnorm, nestedLogit,
#>   nlme, nnet, nonnest2, ordinal, panelr, parameters, parsnip, pbkrtest,
#>   performance, phylolm, plm, PROreg, pscl, psych, quantreg, Rcpp,
#>   RcppEigen, rmarkdown, rms, robustbase, robustlmm, rpart, rstanarm,
#>   rstantools, rstudioapi, RWiener, sandwich, sdmTMB, sampleSelection,
#>   serp, speedglm, splines, statmod, survey, survival, svylme, testthat,
#>   tinytable, TMB, truncreg, tune, tweedie, VGAM, WeightIt, withr
#> 
#> modelbased
#> ----------
#> afex, BH, betareg, boot, bootES, brglm2, brms, coda, collapse,
#>   correlation, coxme, curl, discovr, easystats, effectsize, emmeans,
#>   Formula, gamm4, gganimate, ggplot2, glmmTMB, httr2, knitr, lme4,
#>   lmerTest, logspline, MASS, Matrix, marginaleffects, mice, mgcv, mvtnorm,
#>   nanoparquet, nnet, ordinal, palmerpenguins, performance, patchwork,
#>   pbkrtest, poorman, pscl, RcppEigen, Rdatasets, report, rmarkdown,
#>   rstanarm, rtdists, RWiener, sandwich, see, survival, testthat, tinyplot,
#>   tinytable, vdiffr, withr
#> 
#> parameters
#> ----------
#> AER, afex, aod, BayesFactor, BayesFM, bbmle, betareg, BH, biglm, blme,
#>   boot, brglm2, brms, broom, broom.mixed, cAIC4, car, carData, cgam,
#>   ClassDiscovery, clubSandwich, cluster, cobalt, coda, correlation, coxme,
#>   cplm, curl, dbscan, did, discovr, distributional, domir, drc, DRR,
#>   effectsize, EGAnet, emmeans, epiR, estimatr, factoextra, FactoMineR,
#>   faraway, fastICA, fixest, fpc, gam, gamlss, gee, geepack, ggplot2,
#>   GLMMadaptive, glmmTMB, glmtoolbox, GPArotation, gt, haven, httr2, Hmisc,
#>   ivreg, knitr, lavaan, lcmm, lfe, lm.beta, lme4, lmerTest, lmtest,
#>   logistf, logitr, logspline, lqmm, marginaleffects, modelbased, MASS,
#>   Matrix, mclogit, mclust, MCMCglmm, mediation, merDeriv, metaBMA,
#>   metafor, mfx, mgcv, mice, mmrm, multcomp, MuMIn, mvtnorm, NbClust,
#>   nFactors, nestedLogit, nlme, nnet, openxlsx, ordinal, panelr, pbkrtest,
#>   PCDimension, performance, plm, PMCMRplus, poorman, posterior, PROreg,
#>   pscl, psych, pvclust, quantreg, randomForest, RcppEigen, rmarkdown, rms,
#>   rstan, rstanarm, sampleSelection, sandwich, see, serp, sparsepca,
#>   survey, survival, svylme, testthat, tidyselect, tinytable, TMB,
#>   truncreg, vdiffr, VGAM, WeightIt, withr, WRS2
#> 
#> performance
#> -----------
#> AER, afex, BayesFactor, bayesplot, betareg, bigutilsr, blavaan, boot,
#>   brms, car, carData, CompQuadForm, correlation, cplm, curl, dagitty,
#>   dbscan, DHARMa, discovr, estimatr, fixest, flextable, forecast, ftExtra,
#>   gamm4, ggdag, glmmTMB, GPArotation, graphics, Hmisc, httr2, ICS,
#>   ICSOutlier, ISLR, ivreg, lavaan, lme4, lmtest, loo, MASS, Matrix,
#>   mclogit, mclust, metadat, metafor, mgcv, mlogit, modelbased, multimode,
#>   nestedLogit, nlme, nnet, nonnest2, ordinal, parallel, parameters,
#>   patchwork, pscl, psych, psychTools, quantreg, qqplotr, randomForest,
#>   RcppEigen, reformulas, rempsyc, rmarkdown, rstanarm, rstantools,
#>   sandwich, see, survey, survival, testthat, tweedie, VGAM, withr
#> 
#> report
#> ------
#> BayesFactor, brms, collapse, GLMMadaptive, glmmTMB, ivreg, knitr,
#>   lavaan, lme4, loo, nlme, dplyr, Formula, rmarkdown, rstanarm, survival,
#>   modelbased, emmeans, marginaleffects, RcppEigen, BH, testthat
#> 
#> see
#> ---
#> BH, brms, collapse, curl, DHARMa, discovr, emmeans, factoextra, Formula,
#>   ggdag, ggdist, ggraph, ggrepel, ggridges, ggside, glmmTMB, grid, httr2,
#>   lavaan, lme4, logspline, marginaleffects, MASS, mclogit, mclust,
#>   merDeriv, mgcv, metafor, NbClust, nFactors, psych, qqplotr,
#>   randomForest, RcppEigen, rlang, rmarkdown, rstanarm, scales, splines,
#>   testthat, tidygraph, vdiffr
#> 
```
