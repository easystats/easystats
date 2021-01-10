library(tidyverse)
library(ggeffects)
library(insight)
library(bayestestR)
library(parameters)
library(performance)
library(see)
library(rstanarm)


result$Scale <- factor(result$Scale)
levels(result$Scale) <- c("ultranarrow prior scale", "narrow prior scale", "medium prior scale", "wide prior scale")

d <- result %>%
  group_by(N, Location, Scale) %>%
  filter(N %in% seq(20, 200, 20)) %>%
  summarise(
    Estimate = mean(Median),
    CI_low = min(HDI_low),
    CI_high = max(HDI_high)
  )

p <- ggplot(d, aes(x = as.factor(N), ymin = CI_low, ymax = CI_high, color = as.factor(Location))) +
  geom_hline(yintercept = .3, color = "#5a5a5a", size = .6) +
  geom_errorbar(width = 0, size = .7, position = position_dodge(.8)) +
  facet_wrap(~Scale) +
  theme_lucid() +
  theme(
    # panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank()
  ) +
  scale_color_metro() +
  scale_x_discrete(breaks = seq(0, 200, 50), labels = seq(0, 200, 50)) +
  guides(colour = guide_legend(reverse = TRUE, override.aes = list(alpha = 1))) +
  labs(
    title = "Posterior HDI by Sample Size, Prior Location and Prior Scale",
    subtitle = "for True Effect of 0.3",
    y = "HDI",
    x = "Sample Size",
    colour = "Prior Location"
  )

ggsave("result_uncertainty.pdf", plot = p, device = "pdf", scale = 2, width = 14, height = 12, unit = "cm", dpi = 300)








d <- result
d$Scale <- factor(d$Scale)
d$Location <- factor(d$Location)
levels(d$Scale) <- c("ultranarrow prior scale", "narrow prior scale", "medium prior scale", "wide prior scale")
levels(d$Location) <- c("Prior Location: -0.6", "Prior Location: -0.3", "Prior Location: 0", "Prior Location: 0.3", "Prior Location: 0.6")

d <- d %>%
  group_by(N, Location, Scale) %>%
  filter(N %in% seq(20, 200, 20)) %>%
  summarise(
    Estimate = mean(Median),
    CI_low = min(HDI_low),
    CI_high = max(HDI_high)
  )

p <- ggplot(d, aes(x = as.factor(N), ymin = CI_low, ymax = CI_high, color = as.factor(Scale))) +
  geom_hline(yintercept = .3, color = "#5a5a5a", size = .6) +
  geom_errorbar(width = 0, size = .7, position = position_dodge(.8)) +
  facet_wrap(~as.factor(Location)) +
  theme_lucid() +
  theme(
    # panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank()
  ) +
  scale_color_flat() +
  scale_x_discrete(breaks = seq(0, 200, 50), labels = seq(0, 200, 50)) +
  guides(colour = guide_legend(reverse = TRUE, override.aes = list(alpha = 1))) +
  labs(
    title = "Posterior HDI by Sample Size, Prior Location and Prior Scale",
    subtitle = "for True Effect of 0.3",
    y = "HDI",
    x = "Sample Size",
    colour = "Prior Scale"
  )

ggsave("result_uncertainty3.pdf", plot = p, device = "pdf", scale = 2, width = 14, height = 12, unit = "cm", dpi = 300)









d <- result %>%
  group_by(N, Location, Scale) %>%
  filter(N %in% seq(20, 200, 20)) %>%
  summarise(
    Estimate = mean(Median),
    CI_low = mean(HDI_low),
    CI_high = mean(HDI_high)
  )

p <- ggplot(d, aes(x = as.factor(N), ymin = CI_low, ymax = CI_high, color = as.factor(Location))) +
  geom_hline(yintercept = .3, color = "#5a5a5a", size = .6) +
  geom_errorbar(width = 0, size = .7, position = position_dodge(.8)) +
  facet_wrap(~Scale) +
  theme_lucid() +
  theme(
    # panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank()
  ) +
  scale_color_metro() +
  scale_x_discrete(breaks = seq(0, 200, 50), labels = seq(0, 200, 50)) +
  guides(colour = guide_legend(reverse = TRUE, override.aes = list(alpha = 1))) +
  labs(
    title = "Posterior HDI by Sample Size, Prior Location and Prior Scale",
    subtitle = "for True Effect of 0.3",
    y = "HDI",
    x = "Sample Size",
    colour = "Prior Location"
  )

ggsave("result_uncertainty2.pdf", plot = p, device = "pdf", scale = 2, width = 14, height = 12, unit = "cm", dpi = 300)






d <- result %>%
  group_by(N, Location, Scale) %>%
  summarise(
    Estimate = mean(Median),
    CI_low = mean(HDI_low),
    CI_high = mean(HDI_high)
  )

ggplot(mapping = aes(x = N, ymin = CI_low, ymax = CI_high)) +
  geom_hline(yintercept = .3, color = "#5a5a5a", size = .6) +
  # geom_ribbon(data = filter(d, Location == 0.6), color = "#e51400", alpha = .2, fill = "#e51400") +
  geom_ribbon(data = filter(d, Location == 0.3), color = "#e3c800", alpha = .2, fill = "#e3c800") +
  geom_ribbon(data = filter(d, Location == -0.3), color = "#1ba1e2", alpha = .2, fill = "#1ba1e2") +
  # geom_ribbon(data = filter(d, Location == -0.6), color = "#647687", alpha = .2, fill = "#647687") +
  facet_wrap(~Scale) +
  theme_lucid() +
  theme(
    # panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank()
  )

