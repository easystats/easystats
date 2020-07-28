# https://arxiv.org/abs/1708.07487
library(tidyverse)
library(ggeffects)
library(insight)
library(bayestestR)
library(parameters)
library(effectsize)
library(performance)
library(see)
library(rstanarm)


# simulate data, with true effect of r = 0.3 ----------------------------------

generate_data <- function(sample_size = 50, effect = 0, true_effect = .3) {
  # Generate data
  out <- do.call(rbind, lapply(1:(sample_size / 5), function(i) {
    corr <- rnorm(1, mean = true_effect, sd = true_effect * .25)
    simulate_correlation(n = 5, r = corr, mean = effect, sd = 3)
  }))

  if (nrow(out) < sample_size) {
    out <- rbind(out, simulate_correlation(n = sample_size - nrow(out), r = true_effect, mean = effect, sd = 3))
  }

  d <- standardize(out)
  #d <- standardize(simulate_correlation(n = sample_size, r = true_effect, mean = effect, sd = 3))
  colnames(d) <- c("y", "x")
  d
}



# fit linear models (Bayes and Freq)  ----------------------------------

compute_models <- function(dat, location, scale) {
  # model fitting
  m_freq <- lm(y ~ x, data = dat)

  m_stan <- stan_glm(
    y ~ x,
    data = dat,
    family = gaussian(),
    prior = normal(
      location = location,
      scale = scale,
      autoscale = FALSE
    ),
    refresh = 0,
    chains = 10,
    iter = 800,
    cores = 10
  )

  list(bayes = m_stan, freq = m_freq)
}



# Generate data, fit models, and extract relevant indices --------------------

generate_and_process <- function(sample_size, effect, true_effect, location, scale, simulation) {
  # data
  dat <- generate_data(sample_size, effect, true_effect)

  # models
  models <- compute_models(dat, location, scale)

  # results
  data.frame(
    N = sample_size,
    Location = location,
    Scale = scale,
    Effect = effect,
    Simulation = simulation,
    Mean = point_estimate(models$bayes, "all")$Mean[2],
    Median = point_estimate(models$bayes, "all")$Median[2],
    SD = sd(as.data.frame(models$bayes)[["x"]]),
    MAD = mad(as.data.frame(models$bayes)[["x"]]),
    HDI_low = hdi(models$bayes)$CI_low[2],
    HDI_high = hdi(models$bayes)$CI_high[2],
    Coefficient = coef(models$freq)["x"],
    SE = standard_error(models$freq)$SE[2],
    CI_low = ci(models$freq)$CI_low[2],
    CI_high = ci(models$freq)$CI_high[2],
    stringsAsFactors = FALSE
  )
}



# Define prior scales ----------------------------------------

# "For the rscale argument, several named values are recognized:
# "medium.narrow", "medium", "wide", and "ultrawide". These correspond
# to r scale values of 1/sqrt(27), 1/3, 1/sqrt(3) and 1, respectively.".
# https://www.rdocumentation.org/packages/BayesFactor/versions/0.9.12-4.2/topics/correlationBF)

prior_scales <- 1/sqrt(3^(1:4))

# Setup for simulations (sample size, prior locations)  -----------------------

sample_sizes <- seq(20, 200, by = 5)
locations <- c(-0.6, -0.3, 0, 0.3, 0.6)
effect <- 0
true_effect <- .3
simulations <- 1:200



# prepare output, progress indicator -----------------------

result <- data.frame()
pb <- txtProgressBar(min = 0, max = length(simulations), style = 3)
total_progress <- length(sample_sizes) * length(locations) * length(prior_scales)
current_progress <- 0

set.seed(1207)

tstart <- Sys.time()



# Run, Forest, run!  -----------------------

for (sample_size in sample_sizes) {
  for (location in locations) {
    for (scale in prior_scales) {
      current_progress <- current_progress + 1
      for (simulation in simulations) {
        out <- generate_and_process(
          sample_size = sample_size,
          effect = effect,
          true_effect = true_effect,
          location = location,
          scale = scale,
          simulation = simulation
        )
        result <- rbind(result, out)
        setTxtProgressBar(pb, simulation)
      }
      cat("\nFinished N=", sample_size, ", Location=", location, "\n")
      cat("Total progress:", round(100 * current_progress / total_progress), "%", "\n")
    }
  }
}

cat("\n\nElapsed time for simulations: ")
cat(format(Sys.time() - tstart))
cat("\n\n")



# Add context information and save results -----------------------

attr(result, "elapsed_time") <- format(Sys.time() - tstart)
attr(result, "scale") <- prior_scales
attr(result, "location") <- locations
attr(result, "effect") <- effect
attr(result, "true_effect") <- true_effect

close(pb)

result$Group <- sprintf("N=%i, Location=%g, Scale=%g", result$N, result$Location, result$Scale)

save(result, file = sprintf(
  "simulations_%s.RData",
  gsub(".", "_", make.names(date()), fixed = TRUE)
))
