library(tidyverse)
library(ggeffects)
library(insight)
library(bayestestR)
library(parameters)
library(performance)
library(see)
library(rstanarm)



# Plots of results  -----------------------

pdf("results.pdf", width = 12, height = 12)

ggplot(result, aes(x = as.factor(N), y = Median)) +
  geom_point(alpha = .01, fill = NA, size = 1) +
  facet_wrap(~Location) +
  geom_hline(yintercept = .3, color = "darkred") +
  theme_lucid() +
  theme(
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank()
  )

ggplot(result, aes(x = as.factor(N), y = Median, color = as.factor(Location))) +
  geom_point(alpha = .05, fill = NA, size = 1) +
  geom_hline(yintercept = .3, color = "darkred") +
  theme_lucid() +
  theme(
    # panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank()
  ) +
  scale_color_metro()

dev.off()





# Trend of relation between sample size and prior location  -------------------

mod <- lm(Median ~ poly(N, 3) * Location, data = result)

pdf("results_cubic-effects.pdf", width = 12, height = 12)

ggpredict(mod, c("N", "Location")) %>%
  plot(add.data = TRUE, grid = TRUE, colors = "bw", dot.alpha = .05, dot.size = 1)

ggpredict(mod, c("N", "Location")) %>% plot(colors = "metro")

dev.off()









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

