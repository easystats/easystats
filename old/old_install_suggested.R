#' @keywords internal_list
# styler: off
.suggested_pkgs <- function() {
  list(
    insight     = .find_suggested("insight"),
    datawizard  = .find_suggested("datawizard"),
    performance = .find_suggested("performance"),
    parameters  = .find_suggested("parameters"),
    see         = .find_suggested("see"),
    effectsize  = .find_suggested("effectsize"),
    bayestestR  = .find_suggested("bayestestR"),
    correlation = .find_suggested("correlation"),
    report      = .find_suggested("report"),
    modelbased  = .find_suggested("modelbased")
  )
}
# styler: on



#' @keywords internal_list
.suggested_pkgs_old <- list(
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
  parameters = c(
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
    "BayesFactor", "energy", "Hmisc", "mbend", "polycor", "ppcor", "psych",
    "rmcorr", "wdm"
  ),

  # `report` ----------
  # none
  report = c(),

  # `modelbased` ----------
  modelbased = c("emmeans")
)
