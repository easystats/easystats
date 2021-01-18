library(bayestestR)
library(ggplot2)
# library(strengejacke)

set.seed(123)
posterior <- distribution_chisquared(100, 3)
dat <- as.data.frame(density(posterior))

m <- median(posterior)
ypos <- density_at(posterior, x = m)

m2 <- map_estimate(posterior)
ypos2 <- dat$y[which.min(abs(dat$x - m2))]

m3 <- mean(posterior)
ypos3 <- dat$y[which.min(abs(dat$x - m3))]

label_x <- m + .8
label_y <- ypos + .01

label_x2 <- m2 - 0.5
label_y2 <- ypos2 + .01

label_x3 <- m3 + .8
label_y3 <- ypos3 + .01

ggplot(dat, aes(x = x, y = y)) +
  geom_ribbon(aes(ymin = 0, ymax = y), fill = "#FFC107") +
  geom_vline(xintercept = 0, linetype = "dotted") +
  geom_segment(x = m2, xend = m2, y = 0, yend = ypos2, color = "#E91E63", size = 1) +
  geom_point(x = m2, y = ypos2, color = "#E91E63", size = 5) +
  geom_label(x = label_x2, y = label_y2, label = "MAP", color = "#E91E63", size = 7) +
  geom_segment(x = m, xend = m, y = 0, yend = ypos, color = "#2196F3", size = 1) +
  geom_point(x = m, y = ypos, color = "#2196F3", size = 5) +
  geom_label(x = label_x, y = label_y, label = "Median", color = "#2196F3", size = 7) +
  geom_segment(x = m3, xend = m3, y = 0, yend = ypos3, color = "#4CAF50", size = 1) +
  geom_point(x = m3, y = ypos3, color = "#4CAF50", size = 5) +
  geom_label(x = label_x3, y = label_y3, label = "Mean", color = "#4CAF50", size = 7) +
  theme_classic(base_size = 20) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, .25)) +
  xlab("\nParameter Value") +
  ylab("Probability Density\n")

ggsave("Figure1b.png", width = 13, height = 8, units = "in", dpi = 450)
