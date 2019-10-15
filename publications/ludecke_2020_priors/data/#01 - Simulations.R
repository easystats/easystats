# https://arxiv.org/abs/1708.07487
library(tidyverse)
library(strengejacke)
library(insight)
library(bayestestR)
library(parameters)
library(performance)
library(see)
library(rstanarm)

generate_data <- function(sample_size = 50, error = 3, effect = 5) {
  # Generate data
  d <- data.frame(
    x1 = rnorm(sample_size, runif(1, min = 1, max = effect), error),
    x2 = rnorm(sample_size, 1, 3),
    x3 = rnorm(sample_size, -1, 1.5),
    sigma = rnorm(sample_size, 0, 1)
  )

  b0 <- 10
  b1 <- rnorm(sample_size, effect, error)
  b2 <- 1
  b3 <- -1

  d$y <- b0 + b1 * d$x1 + b2 * d$x2 + b3 * d$x3 + d$sigma

  d
}


compute_models <- function(dat, error, location) {
  # model fitting
  m_freq <- lm(y ~ x1 + x2 + x3, data = dat)

  if (is.na(location)) {
    m_stan <- stan_glm(
      y ~ x1 + x2 + x3,
      data = dat,
      family = gaussian(),
      refresh = 0,
      cores = 4
    )
  } else {
    # mimic auto-scaling of prior-scale
    scale_x2 <- sd(dat$y) * 2.5 / sd(dat$x2)
    scale_x3 <- sd(dat$y) * 2.5 / sd(dat$x3)

    m_stan <- stan_glm(
      y ~ x1 + x2 + x3,
      data = dat,
      family = gaussian(),
      prior = normal(
        location = c(location, 0, 0),
        scale = c(3 * error, scale_x2, scale_x3),
        autoscale = FALSE
      ),
      refresh = 0,
      cores = 4
    )
  }

  list(bayes = m_stan, freq = m_freq)
}


generate_and_process <- function(sample_size, error, effect, location, simulation) {
  # data
  dat <- generate_data(sample_size, error, effect)

  # models
  models <- compute_models(dat, error, location)

  # results
  data.frame(
    # Prior = simulate_prior(models$bayes)[["x1"]],
    # Posterior = as.data.frame(models$bayes)[["x1"]],
    N = sample_size,
    Error = error,
    Location = location,
    Effect = effect,
    Simulation = simulation,
    Mean = point_estimate(models$bayes, "all")$Mean[2],
    Median = point_estimate(models$bayes, "all")$Median[2],
    HDI_low = hdi(models$bayes)$CI_low[2],
    HDI_high = hdi(models$bayes)$CI_high[2],
    Coefficient = coef(models$freq)["x1"],
    CI_low = ci(models$freq)$CI_low[2],
    CI_high = ci(models$freq)$CI_high[2],
    stringsAsFactors = FALSE
  )
}

set.seed(1207)

sample_sizes <- seq(50, 300, by = 50)
locations <- c(NA, 2, 5, 8)
effect <- 5
errors <- c(2, 4, 6, 8)
simulations <- 1:10

result <- data.frame()
pb <- txtProgressBar(min = 0, max = length(simulations), style = 3)
total_progress <- length(sample_sizes) * length(locations) * length(errors)
current_progress <- 0

tstart <- Sys.time()

for (sample_size in sample_sizes) {
  for (location in locations) {
    for (error in errors) {
      current_progress <- current_progress + 1
      for (simulation in simulations) {
        out <- generate_and_process(
          sample_size = sample_size,
          error = error,
          effect = effect,
          location = location,
          simulation = simulation
        )
        result <- rbind(result, out)
        setTxtProgressBar(pb, simulation)
      }
      cat("\nFinished N=", sample_size, ", Location=", location, ", Error=", error, "\n")
      cat("Total progress:", round(100 * current_progress / total_progress), "%", "\n")
    }
  }
}

cat("\n\nElapsed time for simulations: ")
cat(format(Sys.time() - tstart))
cat("\n\n")

attr(result, "elapsed_time") <- format(Sys.time() - tstart)

close(pb)

save(result, file = sprintf(
  "simulations_%i_%s.RData",
  length(simulations),
  gsub(".", "_", make.names(date()), fixed = TRUE)
))

result$Location[is.na(result$Location)] <- "weakly"
result$Group <- sprintf("N=%i, Location=%s, Error=%g", result$N, result$Location, result$Error)

theme_set(theme_sjplot2())

ggplot(result, aes(x = as.factor(Location), y = Median)) +
  geom_boxplot(width = .4) +
  geom_jitter(alpha = .1, width = .1, height = 0, fill = NA) +
  facet_wrap(~N) +
  geom_rug(alpha = .2)

ggplot(result, aes(x = as.factor(N), y = Median)) +
  geom_boxplot(width = .4) +
  geom_jitter(alpha = .1, width = .1, height = 0, fill = NA) +
  facet_wrap(~Location) +
  geom_rug(alpha = .2)

# tmp <- result %>% filter(Location == "weakly")
# tmp$Prior[abs(tmp$Prior) > 20] <- NA
# tmp$Posterior[abs(tmp$Posterior) > 7] <- NA
# tmp <- pivot_longer(tmp, cols = c(Prior, Posterior), names_to = "Sample", values_to = "x")
# tmp$Error <- as.factor(tmp$Error)
#
# ggplot(tmp, aes(x = x, fill = Error)) +
#   geom_density(alpha = .15, color = NA) +
#   facet_wrap(~Sample, scales = "free") +
#   coord_cartesian() +
#   see::scale_fill_social()
#
# ggplot(tmp, aes(x = x, color = Error)) +
#   geom_density(fill = NA) +
#   facet_wrap(~Sample, scales = "free") +
#   coord_cartesian() +
#   see::scale_fill_social() +
#   theme_abyss()

# ps <- prior_summary(m)
# ps$prior
#
# p <- plot_model(m, type = "diag")
# m_pp_data <- filter(p$data, Term == "x1")
# ggplot(m_pp_data, aes(x = Estimate, fill = Sample)) + geom_density(alpha = .4) + labs(y = NULL)
#



# tmp_prior <- estimate_density(simulate_prior(m)[["x1"]])
# tmp_prior$Sample <- "Prior"
# tmp_posterior <- estimate_density(as.data.frame(m)[["x1"]])
# tmp_posterior$Sample <- "Posterior"
#
# tmp <- rbind(tmp_prior, tmp_posterior)
# ggplot(tmp, aes(x = x, y = y, fill = Sample)) +
#   geom_area(alpha = .4) +
#   xlim(c(-10, 10))

