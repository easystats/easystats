#' Download all suggested packages
#'
#' @param package If \code{NULL}, all suggested packages for all 'easystats'
#'   packages will be installed. If a specific package is specified, only
#'   suggested packages for that package will be installed.
#'
#' @details
#'
#' To reduce the dependency load, 'easystats' packages by default will not
#' download all internally needed packages. It will ask the user to download
#' them only if they are needed. The current function can help install all
#' packages a given 'easystats' package might need. For example,
#' \code{install_suggested("see")}.
#'
#' @return
#'
#' Useful only for its side-effect of installing the needed packages.
#'
#' @export

install_suggested <- function(package = NULL) {
  # if you add a new instance of `check_if_installed`, please edit the corresponding entry
  # duplicated entries are fine; we are using unique values anyway
  # please use alphabetical order

  # `insight` --------
  insight_suggested <- c(
    "aod", "BayesFactor", "bbmle", "BGGM", "blavaan", "cplm", "clubSandwich",
    "emmeans", "fungible", "gt", "lavaan", "lme4", "mice", "nlme", "rstanarm",
    "sandwich", "statmod"
  )

  # `datawizard` --------
  datawizard_suggested <- c(
    "boot", "gamm4", "mclust", "multimode", "rstanarm"
  )

  # `performance` --------
  performance_suggested <- c(
    "BayesFactor", "bigutilsr", "blavaan", "brms", "car", "cluster",
    "CompQuadForm", "fixest", "glmmTMB", "emmeans", "lavaan", "lme4",
    "loo", "mclust", "Matrix", "mice", "randomForest", "rstanarm",
    "rstantools", "sandwich", "VGAM"
  )


  # `parameters` --------
  parameters_suggested <- c(
    "aod", "BayesFactor", "cAIC4", "cplm", "DRR", "EGAnet", "fastICA", "glmmTMB",
    "emmeans", "lavaan", "lavaSearch2", "MASS", "lme4", "lmerTest", "loo", "Matrix",
    "mice", "nFactors", "projpred", "sandwich"
  )

  # `see` --------
  see_suggested <- c(
    "emmeans", "ggraph", "grid", "gridExtra", "tidygraph"
  )

  # `effectsize` --------
  effectsize_suggested <- c(
    "BayesFactor", "boot", "lme4", "lmerTest", "rstanarm", "rstantools"
  )

  # `bayestestR` --------
  bayestestR_suggested <- c(
    "BayesFactor", "brms", "bridgesampling", "lme4", "logspline", "MASS",
    "rstan", "rstanarm", "rstantools", "tweedie"
  )

  # `correlation` --------
  correlation_suggested <- c(
    "BayesFactor", "Hmisc", "polycor", "psych", "wdm"
  )

  # `report` ----------
  # none

  # `modelbased` ----------
  modelbased_suggested <- c("emmeans")

  # unique suggested packages to download
  if (!is.null(package)) {
    pkg_download <- switch(package,
      "insight" = insight_suggested,
      "datawizard" = datawizard_suggested,
      "performance" = performance_suggested,
      "parameters" = parameters_suggested,
      "see" = see_suggested,
      "effectsize" = effectsize_suggested,
      "bayestestR" = bayestestR_suggested,
      "correlation" = correlation_suggested,
      "modelbased" = modelbased_suggested,
      NULL # report
    )
  } else {
    pkg_download <- unique(c(
      insight_suggested, datawizard_suggested, performance_suggested,
      parameters_suggested, see_suggested, effectsize_suggested,
      bayestestR_suggested, correlation_suggested, modelbased_suggested
    ))
  }

  # install only the packages not yet installed
  installed_packages <- pkg_download %in% rownames(installed.packages())

  if (any(installed_packages == FALSE)) {
    install.packages(pkg_download[!installed_packages])
  }
}
