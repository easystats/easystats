prior_scales <- 1 / sqrt(3^(1:4))

dat <- do.call(rbind, lapply(prior_scales, function(i) {
  x <- bayestestR::distribution_normal(1000, sd = i)
  out <- bayestestR::estimate_density(x)
  out$Scale <- i
  out
}))

dat$Scale <- factor(dat$Scale)
levels(dat$Scale) <- c("ultranarrow", "narrow", "medium", "wide")

p <- ggplot(dat, aes(x = x, y = y, colour = Scale)) +
  geom_line(size = .7) +
  labs(
    colour = "Prior Scale",
    x = "Parameter range",
    y = NULL,
    title = "Possible Parameter Range",
    subtitle = "for the different prior scales"
  ) +
  theme_lucid() +
  scale_color_metro() +
  scale_x_continuous(breaks = seq(-2, 2, .5), labels = seq(-2, 2, .5)) +
  scale_y_continuous(labels = NULL)

ggsave("prior_range.pdf", plot = p, device = "pdf", scale = 2, width = 11, height = 7, unit = "cm", dpi = 300)
