library(bayestestR)
library(tidyverse)
# library(strengejacke)


# ROPE --------------------------------------------------------------------

set.seed(123)
posterior <- distribution_chisquared(100, 3)
dat <- as.data.frame(density(posterior))

p1 <- dat %>%
  mutate(fill = ifelse(x < -.5, "low",
    ifelse(x > .5, "high", "middle")
  )) %>%
  ggplot(aes(x = x, y = y, fill = fill)) +
  geom_ribbon(aes(ymin = 0, ymax = y)) +
  geom_vline(xintercept = 0, linetype = "dotted") +
  theme_classic(base_size = 20) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, .25)) +
  scale_fill_manual(values = c("high" = "#FFC107", "low" = "#FFC107", "middle" = "#E91E63"), guide = FALSE) +
  ggtitle("Region of Practical Equivalence (ROPE)") +
  theme(plot.title = element_text(hjust = 0.5, size = 18, face = "italic")) +
  xlab(NULL) +
  ylab(NULL)



# PD ----------------------------------------------------------------------

posterior <- distribution_normal(100, 0.4, 0.2)
p2 <- posterior %>%
  density() %>%
  as.data.frame() %>%
  mutate(fill = ifelse(x < 0, "low", "high")) %>%
  ggplot(aes(x = x, y = y, fill = fill)) +
  geom_ribbon(aes(ymin = 0, ymax = y)) +
  geom_vline(xintercept = 0, linetype = "dotted") +
  theme_classic(base_size = 20) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 2)) +
  scale_fill_manual(values = c("high" = "#FFC107", "low" = "#E91E63"), guide = FALSE) +
  ggtitle("Probability of Direction (pd)") +
  theme(plot.title = element_text(hjust = 0.5, size = 18, face = "italic")) +
  xlab(NULL) +
  ylab(NULL)


# sdBF --------------------------------------------------------------------


posterior <- distribution_normal(1000, mean = 1, sd = 0.7) %>%
  density() %>%
  as.data.frame()
prior <- distribution_normal(1000, mean = 0, sd = 1) %>%
  density() %>%
  as.data.frame()

p3 <- posterior %>%
  ggplot(aes(x = x, y = y)) +
  geom_ribbon(aes(ymin = 0, ymax = y), fill = "#FFC107") +
  geom_line(data = prior, size = 1, linetype = "dotted") +
  geom_segment(x = 0, xend = 0, y = 0, yend = max(prior$y), color = "#2196F3", size = 1) +
  geom_point(x = 0, y = max(prior$y), color = "#2196F3", size = 5) +
  geom_segment(x = 0, xend = 0, y = 0, yend = density_at(posterior$x, 0, bw = "nrd0"), color = "#E91E63", size = 1) +
  geom_point(x = 0, y = density_at(posterior$x, 0, bw = "nrd0"), color = "#E91E63", size = 5) +
  theme_classic(base_size = 20) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 0.65)) +
  scale_fill_manual(values = c("high" = "#FFC107", "low" = "#E91E63"), guide = FALSE) +
  ggtitle("Bayes factor") +
  theme(plot.title = element_text(hjust = 0.5, size = 18, face = "italic")) +
  xlab(NULL) +
  ylab(NULL)



# BF (rope) --------------------------------------------------------------------


set.seed(123)
# posterior <- distribution_chisquared(1000, 3) %>%
#   density() %>%
#   as.data.frame() %>%
#   mutate(fill = ifelse(x < -.5, "low2", ifelse(x > .5, "high2", "middle2")))
# prior <- distribution_normal(1000, mean = 0, sd = 1) %>%
#   density() %>%
#   as.data.frame() %>%
#   mutate(fill = ifelse(x < -.5, "low", ifelse(x > .5, "high", "middle")))
#
# # alpha
# ribalpha <- .5
#
# ggplot() +
#   geom_ribbon(data = prior, aes(x=x, fill=fill, ymin=0, ymax=y), alpha = ribalpha) +
#   geom_ribbon(data = posterior, aes(x=x, fill=fill, ymin=0, ymax=y), alpha = ribalpha) +
#   # geom_line(data = prior, aes(x=x, y=y), color = "black", linetype = "dotted") +
#   # geom_line(data = posterior, aes(x=x, y=y), color = "black", linetype = "dotted") +
#   geom_vline(xintercept=0, linetype="dotted") +
#   theme_classic(base_size = 20) +
#   scale_y_continuous(expand = c(0, 0)) +
#   scale_fill_manual(
#     values = c(
#       "high" = "#FFC107",
#       "high2" = "#4CAF50",
#       "low" = "#FFC107",
#       "low2" = "#4CAF50",
#       "middle" = "#E91E63",
#       "middle2" = "#2196F3"
#     ),
#     guide = FALSE
#   ) +
#   ggtitle("Bayes factor (ROPE)") +
#   theme(plot.title = element_text(hjust = 0.5, size = 18, face = "italic")) +
#   xlab(NULL) +
#   ylab(NULL)

x <- seq(-4, 4, length.out = 1000)
posterior <- data.frame(
  x = x,
  y = dnorm(x, 1, 0.7),
  fill = case_when(
    x < -.5 ~ "-out1",
    x > 0.5 ~ "+out1",
    TRUE ~ "in1"
  )
)
prior <- data.frame(
  x = x,
  y = dnorm(x, 0, 1),
  fill = case_when(
    x < -.5 ~ "-out2",
    x > 0.5 ~ "+out2",
    TRUE ~ "in2"
  )
)

# alpha
ribalpha <- 0.8



ggplot() +
  geom_ribbon(
    data = posterior,
    aes(x = x, fill = fill, ymin = 0, ymax = y), alpha = ribalpha
  ) +
  geom_ribbon(
    data = prior,
    aes(x = x, fill = fill, ymin = 0, ymax = y), alpha = ribalpha
  ) +
  geom_line(data = prior, aes(x = x, y = y), color = "black", linetype = "dotted", size = 1) +
  geom_vline(xintercept = c(-.5, .5), linetype = "solid") +
  theme_classic(base_size = 20) +
  scale_y_continuous(expand = c(0, 0)) +
  scale_x_continuous(expand = c(0, 0)) +
  scale_fill_manual(
    values = c(
      "-out1" = "#FFC107",
      "-out2" = NA,
      "+out1" = "#FFC107",
      "+out2" = NA,
      "in1" = "#E91E63",
      "in2" = "#2196F3"
    ),
    guide = FALSE
  ) +
  ggtitle("Bayes factor (ROPE)") +
  theme(plot.title = element_text(hjust = 0.5, size = 18, face = "italic")) +
  xlab(NULL) +
  ylab(NULL)


# p-MAP -------------------------------------------------------------------

set.seed(123)
posterior <- distribution_chisquared(100, 3)
dat <- as.data.frame(density(posterior))

m2 <- map_estimate(posterior)
ypos2 <- dat$y[which.min(abs(dat$x - m2))]

ypos_null <- dat$y[which.min(abs(dat$x))]

p4 <- ggplot(dat, aes(x = x, y = y)) +
  geom_ribbon(aes(ymin = 0, ymax = y), fill = "#FFC107") +
  geom_segment(x = m2, xend = m2, y = 0, yend = ypos2, color = "#E91E63", size = 1) +
  geom_point(x = m2, y = ypos2, color = "#E91E63", size = 5) +
  geom_segment(x = 0, xend = 0, y = 0, yend = ypos_null, color = "#E91E63", size = 1) +
  geom_point(x = 0, y = ypos_null, color = "#E91E63", size = 5) +
  geom_vline(xintercept = 0, linetype = "dotted") +
  theme_classic(base_size = 20) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, .25)) +
  ggtitle("MAP-based p-value") +
  theme(plot.title = element_text(hjust = 0.5, size = 18, face = "italic")) +
  xlab(NULL) +
  ylab(NULL)


# Combine -----------------------------------------------------------------

p <- see::plots(p1, p2, p3, p4, tags = TRUE) # axis are not aligned...

p <- patchwork::wrap_plots(p1, p2, p3, p4, ncol = 2) +
  patchwork::plot_annotation(tag_levels = "A")

# Save --------------------------------------------------------------------

ggsave("Figure3.png", plot = p, width = 13, height = 8, units = "in", dpi = 450)
