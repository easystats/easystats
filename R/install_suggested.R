#' Download all suggested packages
#'
#' @param package If \code{NULL}, all suggested packages for all 'easystats'
#'   packages will be installed. If specific packages are specified, only
#'   suggested packages for those packages will be installed.
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

  if (is.null(package)) {
    package <- names(.suggested_pkgs)
  }

  # unique suggested packages to download
  pkg_download <- unique(unlist(.suggested_pkgs[package]))


  # install only the packages not yet installed
  installed_packages <- pkg_download %in% rownames(installed.packages())

  if (any(!installed_packages)) {
    install.packages(pkg_download[!installed_packages])
  } else {
    message("All of the suggested packages are already installed :)")
  }
}


#' @keywords internal_list
.suggested_pkgs <- list(
  # if you add a new instance of `check_if_installed`, please edit the corresponding entry
  # duplicated entries are fine; we are using unique values anyway
  # please use alphabetical order

  # `insight` --------
  insight = c(
    "aod", "BayesFactor", "bbmle", "BGGM", "blavaan", "cplm", "clubSandwich",
    "emmeans", "fungible", "gt", "lavaan", "lme4", "mice", "nlme", "rstanarm",
    "sandwich", "statmod"
  ),

  # `datawizard` --------
  datawizard = c(
    "boot", "gamm4", "mclust", "multimode", "rstanarm"
  ),

  # `performance` --------
  performance = c(
    "BayesFactor", "bigutilsr", "blavaan", "brms", "car", "cluster",
    "CompQuadForm", "fixest", "glmmTMB", "emmeans", "lavaan", "lme4",
    "loo", "mclust", "Matrix", "mice", "randomForest", "rstanarm",
    "rstantools", "sandwich", "VGAM"
  ),


  # `parameters` --------
  parameters_suggested = c(
    "aod", "BayesFactor", "cAIC4", "cplm", "DRR", "EGAnet", "fastICA", "glmmTMB",
    "emmeans", "lavaan", "lavaSearch2", "MASS", "lme4", "lmerTest", "loo", "Matrix",
    "mice", "nFactors", "projpred", "sandwich"
  ),

  # `see` --------
  see = c(
    "emmeans", "ggraph", "grid", "gridExtra", "tidygraph"
  ),

  # `effectsize` --------
  effectsize = c(
    "BayesFactor", "boot", "lme4", "lmerTest", "rstanarm", "rstantools"
  ),

  # `bayestestR` --------
  bayestestR = c(
    "BayesFactor", "brms", "bridgesampling", "lme4", "logspline", "MASS",
    "rstan", "rstanarm", "rstantools", "tweedie"
  ),

  # `correlation` --------
  correlation = c(
    "BayesFactor", "Hmisc", "polycor", "psych", "wdm"
  ),

  # `report` ----------
  # none
  report = c(),

  # `modelbased` ----------
  modelbased = c("emmeans")
)
