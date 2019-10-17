# https://arxiv.org/abs/1708.07487
library(tidyverse)
library(strengejacke)
library(insight)
library(bayestestR)
library(parameters)
library(performance)
library(see)
library(rstanarm)

generate_data <- function(sample_size = 50, error = 3, effect = 0) {
  # Generate data
  d <- standardize(simulate_correlation(n = sample_size, r = 0.3, mean = effect, sd = error))
  colnames(d) <- c("y", "x")
  d
}


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
    cores = 4
  )

  list(bayes = m_stan, freq = m_freq)
}


generate_and_process <- function(sample_size, error, effect, location, scale, simulation) {
  # data
  dat <- generate_data(sample_size, error, effect)

  # models
  models <- compute_models(dat, location, scale)

  # results
  data.frame(
    N = sample_size,
    Error = error,
    Location = location,
    Effect = effect,
    Simulation = simulation,
    Mean = point_estimate(models$bayes, "all")$Mean[2],
    Median = point_estimate(models$bayes, "all")$Median[2],
    SD = sd(as.data.frame(models$bayes)[["x"]]),
    MAD = mad(as.data.frame(models$bayes)[["x"]]),
    HDI_low = hdi(models$bayes)$CI_low[2],
    HDI_high = hdi(models$bayes)$CI_high[2],
    Coefficient = coef(models$freq)["x"],
    SE = standard_error(models$freq)[2],
    CI_low = ci(models$freq)$CI_low[2],
    CI_high = ci(models$freq)$CI_high[2],
    stringsAsFactors = FALSE
  )
}


sample_sizes <- seq(20, 200, by = 20)
locations <- c(-0.6, -0.3, 0, 0.3, 0.6, 0.9)
scale <- .3
effect <- 0
errors <- 2
simulations <- 1:500

result <- data.frame()
pb <- txtProgressBar(min = 0, max = length(simulations), style = 3)
total_progress <- length(sample_sizes) * length(locations) * length(errors)
current_progress <- 0

set.seed(1207)

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
          scale = scale,
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
attr(result, "scale") <- scale
attr(result, "location") <- locations
attr(result, "effect") <- effect

close(pb)

result$Group <- sprintf("N=%i, Location=%s, Error=%g", result$N, result$Location, result$Error)

save(result, file = sprintf(
  "simulations_%s.RData",
  gsub(".", "_", make.names(date()), fixed = TRUE)
))

result %>%
  group_by(N, Location) %>%
  summarise(
    Estimate = mean(Median),
    CI_low = mean(HDI_low),
    CI_high = mean(HDI_high)
  ) %>%
  print(n = 200)



result %>%
  group_by(N) %>%
  summarise(
    Estimate = mean(Coefficient),
    SE = mean(SE)
  ) %>%
  print(n = 200)


theme_set(theme_lucid())

ggplot(result, aes(x = as.factor(Location), y = Median)) +
  geom_boxplot(width = .4) +
  geom_jitter(alpha = .01, width = .1, height = 0, fill = NA) +
  facet_wrap(~N) +
  geom_rug(alpha = .01)

ggplot(result, aes(x = as.factor(N), y = Median)) +
  geom_boxplot(width = .4) +
  geom_jitter(alpha = .01, width = .1, height = 0, fill = NA) +
  facet_wrap(~Location) +
  geom_rug(alpha = .01)

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
# m_pp_data <- filter(p$data, Term == "x")
# ggplot(m_pp_data, aes(x = Estimate, fill = Sample)) + geom_density(alpha = .4) + labs(y = NULL)
#



# tmp_prior <- estimate_density(simulate_prior(m)[["x"]])
# tmp_prior$Sample <- "Prior"
# tmp_posterior <- estimate_density(as.data.frame(m)[["x"]])
# tmp_posterior$Sample <- "Posterior"
#
# tmp <- rbind(tmp_prior, tmp_posterior)
# ggplot(tmp, aes(x = x, y = y, fill = Sample)) +
#   geom_area(alpha = .4) +
#   xlim(c(-10, 10))

