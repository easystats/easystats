result$Scale <- factor(result$Scale)
levels(result$Scale) <- c("narrow prior scale", "medium prior scale", "wide prior scale", "ultrawide prior scale")

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
  geom_errorbar(width = 0, size = .55, position = position_dodge(.8), alpha = .7) +
  geom_point(
    data = filter(result, N %in% seq(20, 200, 20)),
    mapping = aes(y = Median),
    alpha = .1, fill = NA, size = .7, position = position_dodge(.8)
  ) +
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
    title = "Posterior Median (and HDI) by Sample Size, Prior Location and Prior Scale",
    subtitle = "for True Effect of 0.3",
    y = "Median and Maximum HDI Range",
    x = "Sample Size",
    colour = "Prior Location"
  )

ggsave("result_all.pdf", plot = p, device = "pdf", scale = 2, width = 14, height = 12, unit = "cm", dpi = 600)
