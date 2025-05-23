
# Parameters --------------------------------------------------------------

source("make_data.R")
library(cowplot)
library(grid)
library(gridExtra)

dpi <- 450
size_scaling <- 3
scale_fig_a <- 2.2
scale_fig_b <- 2.5

df$outcome_type <- forcats::fct_rev(df$outcome_type)


# General --------------------------------------------------------------


indices <- c(
  "p_value" = "p-value",
  "p_direction" = "p-direction",
  "p_MAP" = "p-MAP",
  "ROPE_95" = "ROPE (95%)",
  "ROPE_full" = "ROPE (full)",
  "BF_log" = "Bayes factor (vs. 0)",
  "BF_ROPE_log" = "Bayes factor (vs. ROPE)",
  "binary" = "Logistic Model",
  "linear" = "Linear Model",
  "0" = "Absence of Effect",
  "1" = "Presence of Effect"
)


not_last_p <- list(
  theme(
    axis.title.x = element_blank(),
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    legend.position = "none"
  ),
  xlab("")
)

not_first_p <- list(
  theme(
    strip.background = element_blank(), strip.text = element_blank(),
    legend.position = "none"
  )
)





# Figure 1 ----------------------------------------------------------------

set.seed(123)
posterior <- bayestestR::distribution_beta(1000, 2, 4) - 0.1
data <- as.data.frame(density(posterior, bw = "SJ", adjust = 1))
max_y <- max(data$y) + 0.08

# pd
p1 <- data %>%
  mutate(fill = ifelse(x >= 0, "high", "low")) %>%
  ggplot(aes(x = x, y = y, fill = fill)) +
  geom_segment(x = 0, xend = 0, y = bayestestR::density_at(posterior, 0), yend = max_y, linetype = "dotted") +
  geom_ribbon(aes(ymin = 0, ymax = y), size = 1) +
  theme_classic(base_size = 20) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, max_y)) +
  scale_fill_manual(values = c("high" = "#FFC107", "low" = "#E91E63"), guide = FALSE) +
  ggtitle("Probability of Direction (pd)") +
  theme(plot.title = element_text(hjust = 0.5, size = 18, face = "italic")) +
  xlab(NULL) +
  ylab(NULL)


# p-MAP
m2 <- bayestestR::map_estimate(posterior)
ypos2 <- data$y[which.min(abs(data$x - m2))]
ypos_null <- data$y[which.min(abs(data$x))]

p2 <- data %>%
  ggplot(aes(x = x, y = y)) +
  geom_segment(x = 0, xend = 0, y = bayestestR::density_at(posterior, 0), yend = max_y, linetype = "dotted") +
  geom_ribbon(aes(ymin = 0, ymax = y), fill = "#FFC107") +
  geom_segment(x = m2, xend = m2, y = 0, yend = ypos2, color = "#2196F3", size = 1) +
  geom_point(x = m2, y = ypos2, color = "#2196F3", size = 5) +
  geom_segment(x = 0, xend = 0, y = 0, yend = ypos_null, color = "#E91E63", size = 1) +
  geom_point(x = 0, y = ypos_null, color = "#E91E63", size = 5) +
  theme_classic(base_size = 20) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, max_y)) +
  ggtitle("MAP-based p-value") +
  theme(plot.title = element_text(hjust = 0.5, size = 18, face = "italic")) +
  xlab(NULL) +
  ylab(NULL)



# ROPE
hdi <- bayestestR::hdi(posterior, ci = .95)

p3 <- data %>%
  mutate(fill = ifelse(x <= hdi$CI_low, "CI_low",
    ifelse(x <= -.04, "low",
      ifelse(x >= hdi$CI_high, "CI_high",
        ifelse(x >= .04, "high", "middle")
      )
    )
  )) %>%
  ggplot(aes(x = x, y = y, fill = fill, alpha = fill)) +
  geom_ribbon(aes(ymin = 0, ymax = y)) +
  geom_vline(xintercept = 0, linetype = "dotted") +
  theme_classic(base_size = 20) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, max(data$y))) +
  scale_fill_manual(values = c("CI_low" = "#FFC107", "low" = "#FFC107", "middle" = "#E91E63", "high" = "#FFC107", "CI_high" = "#FFC107"), guide = FALSE) +
  scale_alpha_manual(values = c("CI_low" = 0.35, "low" = 1, "middle" = 1, "high" = 1, "CI_high" = 0.35), guide = FALSE) +
  ggtitle("Region of Practical Equivalence (ROPE)") +
  theme(plot.title = element_text(hjust = 0.5, size = 18, face = "italic")) +
  xlab(NULL) +
  ylab(NULL)




# BF
prior <- bayestestR::distribution_normal(1000, mean = 0, sd = 0.2) %>%
  density() %>%
  as.data.frame()

p4 <- data %>%
  mutate(fill = ifelse(x <= -.05, "low",
    ifelse(x >= .05, "high", "middle")
  )) %>%
  ggplot(aes(x = x, y = y)) +
  # distributions
  geom_ribbon(aes(ymin = 0, ymax = y, fill = fill)) +
  geom_ribbon(data = filter(prior, between(x, -0.05, 0.05)), aes(ymin = 0, ymax = y), fill = "#2196F3", alpha = 0.33) +
  geom_line(data = prior, size = 1, linetype = "dotted") +
  # prior null
  geom_segment(x = 0, xend = 0, y = 0, yend = max(prior$y), color = "#2196F3", size = 1) +
  geom_point(x = 0, y = max(prior$y), color = "#2196F3", size = 5) +
  # posterior null
  geom_segment(x = 0, xend = 0, y = 0, yend = bayestestR::density_at(posterior, 0, bw = "nrd0"), color = "#E91E63", size = 1) +
  geom_point(x = 0, y = bayestestR::density_at(posterior, 0, bw = "nrd0"), color = "#E91E63", size = 5) +
  # make pretty
  theme_classic(base_size = 20) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, max_y)) +
  scale_fill_manual(values = c("high" = "#FFC107", "middle" = "#E91E63", "low" = "#FFC107"), guide = FALSE) +
  ggtitle("Bayes Factors (BF)") +
  theme(plot.title = element_text(hjust = 0.5, size = 18, face = "italic")) +
  xlab(NULL) +
  ylab(NULL)

figure1 <- patchwork::wrap_plots(p1, p2, p3, p4, ncol = 2) +
  patchwork::plot_annotation(tag_levels = "A")
figure1


ggsave(paste0(path, "figures/Figure1.png"),
  figure1,
  width = 29.7 / scale_fig_b, height = 21 / scale_fig_b,
  dpi = dpi
)
ggsave(paste0(path, "figures/Figure1.tiff"),
  figure1,
  width = 29.7 / scale_fig_b, height = 21 / scale_fig_b,
  compress = "lzw",
  dpi = dpi
)




# Figure 2 ----------------------------------------------------------------

figure2_data <- df %>%
  select(
    outcome_type, true_effect, error, sample_size,
    p_value, p_direction, p_MAP,
    ROPE_95, ROPE_full,
    BF_log, BF_ROPE_log
  ) %>%
  gather(index, value, -error, -sample_size, -true_effect, -outcome_type) %>%
  mutate(
    true_effect = as.factor(true_effect),
    index = factor(index, levels = c("p_value", "p_direction", "p_MAP", "ROPE_95", "ROPE_full", "BF_log", "BF_ROPE_log"))
  ) %>%
  mutate(temp = as.factor(cut(sample_size, 9, labels = FALSE))) %>%
  group_by(temp) %>%
  mutate(size_group = round(mean(sample_size))) %>%
  ungroup()



figure2_elements <- list(
  aes(size_group, value,
    fill = true_effect,
    group = interaction(true_effect, size_group)
  ),
  geom_boxplot(outlier.shape = NA),
  facet_grid(~outcome_type, scales = "free", labeller = as_labeller(indices)),
  scale_fill_manual(
    name = "Null Hypothesis",
    guide = guide_legend(title.position = "top", title.hjust = 0.5),
    values = c(`0` = "#E91E63", `1` = "#4CAF50"),
    labels = c(`0` = "True", `1` = "False")
  ),
  theme_modern(),
  theme(
    legend.position = "top",
    axis.title.y = element_text(size = 11.5)
  ),
  scale_x_continuous(breaks = c(seq(20, 100, length.out = 9))),
  xlab("Sample Size")
)



figure2_pvalue <-
  figure2_data %>%
  filter(index == "p_value") %>%
  ggplot() +
  geom_hline(yintercept = 0.05, alpha = 0.15) +
  figure2_elements +
  scale_y_continuous(
    breaks = c(seq(0, 1, length.out = 6)),
    labels = c("0", ".2", ".4", ".6", ".8", "1")
  ) +
  ylab("p-value")

figure2_pd <-
  figure2_data %>%
  filter(index == "p_direction") %>%
  ggplot() +
  figure2_elements +
  # geom_hline(yintercept = 0.95, linetype = "dashed") +
  scale_y_continuous(
    breaks = c(seq(0.5, 1, length.out = 6)),
    labels = c("50%", "60%", "70%", "80%", "90%", "100%")
  ) +
  ylab("p-direction")

figure2_pmap <-
  figure2_data %>%
  filter(index == "p_MAP") %>%
  ggplot() +
  figure2_elements +
  # geom_hline(yintercept = 0.05, linetype = "dashed") +
  scale_y_continuous(
    breaks = c(seq(0, 1, length.out = 6)),
    labels = c("0", ".2", ".4", ".6", ".8", "1")
  ) +
  ylab("p-MAP")

figure2_ROPE_95 <-
  figure2_data %>%
  filter(index == "ROPE_95") %>%
  ggplot() +
  figure2_elements +
  # geom_hline(yintercept = 0.05, linetype = "dashed") +
  scale_y_continuous(
    breaks = c(seq(0, 1, length.out = 6)),
    labels = c("0", ".2", ".4", ".6", ".8", "1")
  ) +
  ylab("ROPE (95%)")

figure2_ROPE_full <-
  figure2_data %>%
  filter(index == "ROPE_full") %>%
  ggplot() +
  figure2_elements +
  # geom_hline(yintercept = 0.05, linetype = "dashed") +
  scale_y_continuous(
    breaks = c(seq(0, 1, length.out = 6)),
    labels = c("0", ".2", ".4", ".6", ".8", "1")
  ) +
  ylab("ROPE (full)")

figure2_BF <-
  figure2_data %>%
  filter(index == "BF_log") %>%
  ggplot() +
  geom_hline(yintercept = log(c(1 / 3, 3)), alpha = 0.15) +
  figure2_elements +
  scale_y_continuous(
    breaks = log(c(1 / 100, 1 / 30, 1 / 10, 1 / 3, 1, 3, 10, 30, 100)),
    labels = c("1/100", "1/30", "1/10", "1/3", "1", "3", "10", "30", "100")
  ) +
  ylab("Bayes factor (vs. 0)") +
  coord_cartesian(ylim = log(c(1 / 30, 300)))

figure2_BF_rope <-
  figure2_data %>%
  filter(index == "BF_ROPE_log") %>%
  ggplot() +
  geom_hline(yintercept = log(c(1 / 3, 3)), alpha = 0.15) +
  figure2_elements +
  scale_y_continuous(
    breaks = log(c(1 / 100, 1 / 30, 1 / 10, 1 / 3, 1, 3, 10, 30, 100)),
    labels = c("1/100", "1/30", "1/10", "1/3", "1", "3", "10", "30", "100")
  ) +
  ylab("Bayes factor (vs. ROPE)") +
  coord_cartesian(ylim = log(c(1 / 30, 300)))

figure2_cow <- plot_grid(
  figure2_pvalue + not_last_p,
  figure2_pd + not_last_p + not_first_p,
  figure2_pmap + not_last_p + not_first_p,
  figure2_ROPE_95 + not_last_p + not_first_p,
  figure2_ROPE_full + not_last_p + not_first_p,
  figure2_BF + not_last_p + not_first_p,
  figure2_BF_rope + not_first_p,
  align = "v",
  rel_heights = c(1.5, rep(1.2, times = 5), 1.7),
  ncol = 1
)

effects_legend <- get_legend(
  figure2_pvalue + theme(legend.box.margin = margin(1, 0, 1, 0))
)

figure2 <- plot_grid(effects_legend, figure2_cow,
  ncol = 1, rel_heights = c(0.5, 7)
)
# figure2
ggsave(paste0(path, "figures/Figure2.png"),
  figure2,
  width = 21 / scale_fig_b, height = 29.7 / scale_fig_b,
  dpi = dpi
)
ggsave(paste0(path, "figures/Figure2.tiff"),
  figure2,
  width = 21 / scale_fig_b, height = 29.7 / scale_fig_b,
  compress = "lzw",
  dpi = dpi
)


# Figure 3 ----------------------------------------------------------------

figure3_data <- df %>%
  select(
    outcome_type, true_effect, error, sample_size,
    p_value, p_direction, p_MAP, ROPE_95, ROPE_full, BF_log, BF_ROPE_log
  ) %>%
  gather(index, value, -error, -sample_size, -true_effect, -outcome_type) %>%
  mutate(
    true_effect = as.factor(true_effect),
    index = factor(index, levels = c("p_value", "p_direction", "p_MAP", "ROPE_95", "ROPE_full", "BF_log", "BF_ROPE_log"))
  ) %>%
  mutate(temp = as.factor(cut(error, 6, labels = FALSE))) %>%
  group_by(temp) %>%
  mutate(error_group = round(mean(error))) %>%
  ungroup() %>%
  mutate(error_group = ifelse(true_effect == 0, "Only Noise", error_group))


figure3_elements <- list(
  aes(error_group, value, fill = true_effect),
  geom_boxplot(outlier.shape = NA),
  facet_grid(~outcome_type, scales = "free", labeller = as_labeller(indices)),
  scale_fill_manual(
    name = "Null Hypothesis",
    guide = guide_legend(title.position = "top", title.hjust = 0.5),
    values = c(`0` = "#E91E63", `1` = "#4CAF50"),
    labels = c(`0` = "True", `1` = "False")
  ),
  theme_modern(),
  theme(
    legend.position = "top",
    axis.title.y = element_text(size = 11.5)
  ),
  xlab("Amount of Noise (SD)")
)

figure3_pvalue <-
  figure3_data %>%
  filter(index == "p_value") %>%
  ggplot() +
  geom_hline(yintercept = 0.05, alpha = 0.15) +
  figure3_elements +
  scale_y_continuous(
    breaks = c(seq(0, 1, length.out = 6)),
    labels = c("0", ".2", ".4", ".6", ".8", "1")
  ) +
  ylab("p-value")

figure3_pd <-
  figure3_data %>%
  filter(index == "p_direction") %>%
  ggplot() +
  figure3_elements +
  # geom_hline(yintercept = 0.95, linetype = "dashed") +
  scale_y_continuous(
    breaks = c(seq(0.5, 1, length.out = 6)),
    labels = c("50%", "60%", "70%", "80%", "90%", "100%")
  ) +
  ylab("p-direction")

figure3_pmap <-
  figure3_data %>%
  filter(index == "p_MAP") %>%
  ggplot() +
  figure3_elements +
  # geom_hline(yintercept = 0.05, linetype = "dashed") +
  scale_y_continuous(
    breaks = c(seq(0, 1, length.out = 6)),
    labels = c("0", ".2", ".4", ".6", ".8", "1")
  ) +
  ylab("p-MAP")

figure3_ROPE_95 <-
  figure3_data %>%
  filter(index == "ROPE_95") %>%
  ggplot() +
  figure3_elements +
  # geom_hline(yintercept = 0.05, linetype = "dashed") +
  scale_y_continuous(
    breaks = c(seq(0, 1, length.out = 6)),
    labels = c("0", ".2", ".4", ".6", ".8", "1")
  ) +
  ylab("ROPE (95%)")

figure3_ROPE_full <-
  figure3_data %>%
  filter(index == "ROPE_full") %>%
  ggplot() +
  figure3_elements +
  # geom_hline(yintercept = 0.05, linetype = "dashed") +
  scale_y_continuous(
    breaks = c(seq(0, 1, length.out = 6)),
    labels = c("0", ".2", ".4", ".6", ".8", "1")
  ) +
  ylab("ROPE (full)")

figure3_BF <-
  figure3_data %>%
  filter(index == "BF_log") %>%
  ggplot() +
  geom_hline(yintercept = log(c(1 / 3, 3)), alpha = 0.15) +
  figure3_elements +
  scale_y_continuous(
    breaks = log(c(1 / 100, 1 / 30, 1 / 10, 1 / 3, 1, 3, 10, 30, 100)),
    labels = c("1/100", "1/30", "1/10", "1/3", "1", "3", "10", "30", "100")
  ) +
  ylab("Bayes factor (vs. 0)") +
  coord_cartesian(ylim = log(c(1 / 30, 300)))

figure3_BF_rope <-
  figure3_data %>%
  filter(index == "BF_ROPE_log") %>%
  ggplot() +
  geom_hline(yintercept = log(c(1 / 3, 3)), alpha = 0.15) +
  figure3_elements +
  scale_y_continuous(
    breaks = log(c(1 / 100, 1 / 30, 1 / 10, 1 / 3, 1, 3, 10, 30, 100)),
    labels = c("1/100", "1/30", "1/10", "1/3", "1", "3", "10", "30", "100")
  ) +
  ylab("Bayes factor (vs. ROPE)") +
  coord_cartesian(ylim = log(c(1 / 30, 300)))


figure3_cow <- plot_grid(
  figure3_pvalue + not_last_p,
  figure3_pd + not_last_p + not_first_p,
  figure3_pmap + not_last_p + not_first_p,
  figure3_ROPE_95 + not_last_p + not_first_p,
  figure3_ROPE_full + not_last_p + not_first_p,
  figure3_BF + not_last_p + not_first_p,
  figure3_BF_rope + not_first_p,
  align = "v",
  rel_heights = c(1.5, rep(1.2, times = 5), 1.7),
  ncol = 1
)

figure3 <- plot_grid(effects_legend, figure3_cow,
  ncol = 1, rel_heights = c(0.5, 7)
)

# figure3
ggsave(paste0(path, "figures/Figure3.png"),
  figure3,
  width = 21 / scale_fig_b, height = 29.7 / scale_fig_b,
  dpi = dpi
)
ggsave(paste0(path, "figures/Figure3.tiff"),
  figure3,
  width = 21 / scale_fig_b, height = 29.7 / scale_fig_b,
  compress = "lzw",
  dpi = dpi
)




# Figure 4 ----------------------------------------------------------------

figure4_alpha <- 0.025

figure4_data <- df %>%
  dplyr::select(outcome_type, true_effect, error, sample_size, p_value, p_direction, p_MAP, ROPE_95, ROPE_full, BF_log, BF_ROPE_log) %>%
  gather(index, value, -error, -sample_size, -true_effect, -outcome_type, -p_value) %>%
  mutate(
    true_effect = as.factor(true_effect),
    index = factor(index, levels = c("p_direction", "p_MAP", "ROPE_95", "ROPE_full", "BF_log", "BF_ROPE_log"))
  ) %>%
  mutate(temp = as.factor(cut(sample_size, 3, labels = FALSE))) %>%
  group_by(temp) %>%
  mutate(size_group = as.character(round(mean(sample_size)))) %>%
  ungroup()

figure4_elements <- list(
  aes(p_value, value, color = true_effect, shape = size_group),
  geom_vline(xintercept = 0.05, alpha = 0.15),
  geom_point(alpha = figure4_alpha, stroke = 0),
  facet_grid(~outcome_type, scales = "free", labeller = as_labeller(indices)),
  scale_color_manual(
    name = "Null Hypothesis",
    guide = guide_legend(title.position = "top", title.hjust = 0.5),
    values = c(`0` = "#E91E63", `1` = "#4CAF50"),
    labels = c(`0` = "True", `1` = "False")
  ),
  scale_shape_manual(values = c(0:6, 8, 9), guide = FALSE),
  scale_x_continuous(
    breaks = c(seq(0, 1, length.out = 6), 0.05),
    labels = c("0", ".2", ".4", ".6", ".8", "1", ".05")
  ),
  theme_modern(),
  theme(
    legend.position = "top",
    axis.title.y = element_text(size = 11.5)
  ),
  xlab("p-value")
)

figure4_pd <-
  figure4_data %>%
  filter(index == "p_direction") %>%
  ggplot() +
  figure4_elements +
  geom_rug(alpha = figure4_alpha, sides = "rt", data = filter(figure4_data, index == "p_direction", true_effect == 0)) +
  geom_rug(alpha = figure4_alpha, sides = "lb", data = filter(figure4_data, index == "p_direction", true_effect == 1)) +
  # geom_hline(yintercept = 0.95, linetype = "dashed") +
  scale_y_continuous(
    breaks = c(seq(0.5, 1, length.out = 6)),
    labels = c("50%", "60%", "70%", "80%", "90%", "100%")
  ) +
  ylab("p-direction")

figure4_pmap <-
  figure4_data %>%
  filter(index == "p_MAP") %>%
  ggplot() +
  figure4_elements +
  geom_rug(alpha = figure4_alpha, sides = "rt", data = filter(figure4_data, index == "p_MAP", true_effect == 0)) +
  geom_rug(alpha = figure4_alpha, sides = "lb", data = filter(figure4_data, index == "p_MAP", true_effect == 1)) +
  # geom_hline(yintercept = 0.05, linetype = "dashed") +
  scale_y_continuous(
    breaks = c(seq(0, 1, length.out = 6)),
    labels = c("0", ".2", ".4", ".6", ".8", "1")
  ) +
  ylab("p-MAP")

figure4_ROPE_95 <-
  figure4_data %>%
  filter(index == "ROPE_95") %>%
  ggplot() +
  figure4_elements +
  geom_rug(alpha = figure4_alpha, sides = "rt", data = filter(figure4_data, index == "ROPE_95", true_effect == 0)) +
  geom_rug(alpha = figure4_alpha, sides = "lb", data = filter(figure4_data, index == "ROPE_95", true_effect == 1)) +
  # geom_hline(yintercept = 0.05, linetype = "dashed") +
  scale_y_continuous(
    breaks = c(seq(0, 1, length.out = 6)),
    labels = c("0", ".2", ".4", ".6", ".8", "1")
  ) +
  ylab("ROPE (95%)")

figure4_ROPE_full <-
  figure4_data %>%
  filter(index == "ROPE_full") %>%
  ggplot() +
  figure4_elements +
  geom_rug(alpha = figure4_alpha, sides = "rt", data = filter(figure4_data, index == "ROPE_full", true_effect == 0)) +
  geom_rug(alpha = figure4_alpha, sides = "lb", data = filter(figure4_data, index == "ROPE_full", true_effect == 1)) +
  # geom_hline(yintercept = 0.05, linetype = "dashed") +
  scale_y_continuous(
    breaks = c(seq(0, 1, length.out = 6)),
    labels = c("0", ".2", ".4", ".6", ".8", "1")
  ) +
  ylab("ROPE (full)")

figure4_BF <-
  figure4_data %>%
  filter(index == "BF_log") %>%
  ggplot() +
  figure4_elements +
  geom_rug(alpha = figure4_alpha, sides = "rt", data = filter(figure4_data, index == "BF_log", true_effect == 0)) +
  geom_rug(alpha = figure4_alpha, sides = "lb", data = filter(figure4_data, index == "BF_log", true_effect == 1)) +
  geom_hline(yintercept = log(c(1 / 3, 3)), alpha = 0.15) +
  scale_y_continuous(
    breaks = log(c(1 / 100, 1 / 30, 1 / 10, 1 / 3, 1, 3, 10, 30, 100)),
    labels = c("1/100", "1/30", "1/10", "1/3", "1", "3", "10", "30", "100")
  ) +
  ylab("Bayes factor (vs. 0)") +
  coord_cartesian(ylim = log(c(1 / 30, 300)))

figure4_BF_rope <-
  figure4_data %>%
  filter(index == "BF_ROPE_log") %>%
  ggplot() +
  figure4_elements +
  geom_rug(alpha = figure4_alpha, sides = "rt", data = filter(figure4_data, index == "BF_ROPE_log", true_effect == 0)) +
  geom_rug(alpha = figure4_alpha, sides = "lb", data = filter(figure4_data, index == "BF_ROPE_log", true_effect == 1)) +
  geom_hline(yintercept = log(c(1 / 3, 3)), alpha = 0.15) +
  scale_y_continuous(
    breaks = log(c(1 / 100, 1 / 30, 1 / 10, 1 / 3, 1, 3, 10, 30, 100)),
    labels = c("1/100", "1/30", "1/10", "1/3", "1", "3", "10", "30", "100")
  ) +
  ylab("Bayes factor (vs. ROPE)") +
  coord_cartesian(ylim = log(c(1 / 30, 300)))

figure4_cow <- plot_grid(
  figure4_pd + not_last_p,
  figure4_pmap + not_last_p + not_first_p,
  figure4_ROPE_95 + not_last_p + not_first_p,
  figure4_ROPE_full + not_last_p + not_first_p,
  figure4_BF + not_last_p + not_first_p,
  figure4_BF_rope + not_first_p,
  align = "v",
  rel_heights = c(1.5, rep(1.2, times = 4), 1.7),
  ncol = 1
)

figure4 <- plot_grid(effects_legend, figure4_cow,
  ncol = 1, rel_heights = c(0.5, 7)
)

# figure4
ggsave(paste0(path, "figures/Figure4.png"),
  figure4,
  width = 21 / scale_fig_b, height = 29.7 / scale_fig_b,
  dpi = dpi
)
ggsave(paste0(path, "figures/Figure4.tiff"),
  figure4,
  width = 21 / scale_fig_b, height = 29.7 / scale_fig_b,
  compress = "lzw",
  dpi = dpi
)


# Figure 5 ----------------------------------------------------------------

make_figure5 <- function(.data) {
  .data$level <- ifelse(.data$level == "n.s.", 0, 1)
  fit <- suppressWarnings(glm(level ~ value, data = .data, family = "binomial"))
  newdata <- data.frame(value = seq(min(.data$value), max(.data$value), length.out = 500))
  newdata$sig <- predict(fit, newdata = newdata, type = "response")
  newdata
}

figure5_data <- df %>%
  select(outcome_type, p_value, p_direction, p_MAP, ROPE_95, ROPE_full, BF_log, BF_ROPE_log) %>%
  mutate(
    sig_1 = ifelse(p_value >= .1, "n.s.", "*") %>% factor(levels = c("n.s.", "*")),
    sig_05 = ifelse(p_value >= .05, "n.s.", "*") %>% factor(levels = c("n.s.", "*")),
    sig_01 = ifelse(p_value >= .01, "n.s.", "*") %>% factor(levels = c("n.s.", "*")),
    sig_001 = ifelse(p_value >= .001, "n.s.", "*") %>% factor(levels = c("n.s.", "*"))
  ) %>%
  gather("threshold", "level", sig_1:sig_001) %>%
  gather("index", "value", p_direction, p_MAP, ROPE_95, ROPE_full, BF_log, BF_ROPE_log) %>%
  group_by(outcome_type, index, threshold) %>%
  nest() %>%
  mutate(data = lapply(data, make_figure5)) %>%
  unnest() %>%
  ungroup() %>%
  mutate(
    threshold = factor(threshold, levels = c("sig_1", "sig_05", "sig_01", "sig_001")),
    index = factor(index, levels = c("p_direction", "p_MAP", "ROPE_95", "ROPE_full", "BF_log", "BF_ROPE_log"))
  )

figure5_elements <- list(
  aes(
    x = value, y = sig,
    linetype = threshold, color = outcome_type,
    group = interaction(outcome_type, threshold)
  ),
  geom_line(aes(color = outcome_type), size = 1),
  scale_y_continuous(
    breaks = seq(0, 1, length.out = 5),
    expand = c(0, 0)
  ),
  scale_color_manual(
    name = "Model Type",
    values = c(`linear` = "#2196F3", `binary` = "#FF9800"),
    labels = c(`linear` = "Linear", `binary` = "Logistic")
  ),
  scale_linetype_manual(
    name = "Threshold",
    values = c("sig_1" = "dotted", "sig_05" = "dashed", "sig_01" = "longdash", "sig_001" = "solid"),
    labels = c("p < .1", "p < .05", "p < .01", "p < .001")
  ),
  theme_modern(),
  theme(legend.position = "right"),
  ylab("Probability of being significant")
)

figure5_pd <-
  figure5_data %>%
  filter(index == "p_direction") %>%
  ggplot() +
  figure5_elements +
  # geom_hline(yintercept = 0.50, linetype = "dotted", alpha = 0.5) +
  # geom_vline(xintercept = 0.95, linetype = "dashed") +
  scale_x_continuous(
    breaks = c(0.925, 0.95, 0.975, 1),
    labels = c("92.5%", "95%", "97.5%", "100%")
  ) +
  xlab("p-direction") +
  coord_cartesian(xlim = c(0.925, 1))

figure5_pmap <-
  figure5_data %>%
  filter(index == "p_MAP") %>%
  ggplot() +
  figure5_elements +
  # geom_vline(xintercept = 0.05, linetype = "dashed") +
  scale_x_continuous(
    breaks = seq(0, 0.4, length.out = 5),
    labels = c("0", ".1", ".2", ".3", ".4")
  ) +
  xlab("p-MAP") +
  coord_cartesian(xlim = c(0, 0.4))

figure5_ROPE_95 <-
  figure5_data %>%
  filter(index == "ROPE_95") %>%
  ggplot() +
  figure5_elements +
  # geom_vline(xintercept = 0.05, linetype = "dashed") +
  scale_x_continuous(
    breaks = seq(0, 0.4, length.out = 5),
    labels = c("0", ".1", ".2", ".3", ".4")
  ) +
  xlab("ROPE (95%)") +
  coord_cartesian(xlim = c(0, 0.4))

figure5_ROPE_full <-
  figure5_data %>%
  filter(index == "ROPE_full") %>%
  ggplot() +
  figure5_elements +
  # geom_vline(xintercept = 0.05, linetype = "dashed") +
  scale_x_continuous(
    breaks = seq(0, 0.4, length.out = 5),
    labels = c("0", ".1", ".2", ".3", ".4")
  ) +
  xlab("ROPE (full)") +
  coord_cartesian(xlim = c(0, 0.4))

figure5_BF <-
  figure5_data %>%
  filter(index == "BF_log") %>%
  ggplot() +
  geom_vline(xintercept = log(c(1 / 3, 3)), alpha = 0.15) +
  figure5_elements +
  # geom_vline(xintercept = log(c(1 / 3, 3)), linetype = "dashed") +
  scale_x_continuous(
    breaks = log(c(1 / 100, 1 / 30, 1 / 10, 1 / 3, 1, 3, 10, 30, 100)),
    labels = c("1/100", "1/30", "1/10", "1/3", "1", "3", "10", "30", "100")
  ) +
  xlab("Bayes factor (vs. 0)") +
  coord_cartesian(xlim = log(c(1 / 30, 300)))


figure5_BF_rope <-
  figure5_data %>%
  filter(index == "BF_ROPE_log") %>%
  ggplot() +
  geom_vline(xintercept = log(c(1 / 3, 3)), alpha = 0.15) +
  figure5_elements +
  # geom_vline(xintercept = log(c(1 / 3, 3)), linetype = "dashed") +
  scale_x_continuous(
    breaks = log(c(1 / 100, 1 / 30, 1 / 10, 1 / 3, 1, 3, 10, 30, 100)),
    labels = c("1/100", "1/30", "1/10", "1/3", "1", "3", "10", "30", "100")
  ) +
  xlab("Bayes factor (vs. ROPE)") +
  coord_cartesian(xlim = log(c(1 / 30, 300)))

figure5_no_y <- theme(legend.position = "none", axis.title.y = element_blank())

figure5_cow <- plot_grid(
  figure5_pd + figure5_no_y,
  figure5_ROPE_95 + figure5_no_y,
  figure5_BF + figure5_no_y,
  figure5_pmap + figure5_no_y,
  figure5_ROPE_full + figure5_no_y,
  figure5_BF_rope + figure5_no_y,
  nrow = 2,
  align = "v"
)

sig_legend <- get_legend(
  figure5_pd + theme(legend.box.margin = margin(0, 1, 0, 1))
)

y.grob <- textGrob("Probability of being significant", rot = 90)

figure5 <- grid.arrange(arrangeGrob(
  plot_grid(figure5_cow, sig_legend,
    ncol = 2, rel_widths = c(8, 1)
  ),
  left = y.grob
))

# figure5
ggsave(paste0(path, "figures/Figure5.png"),
  figure5,
  width = 29.7 / scale_fig_b, height = 21 / scale_fig_b,
  dpi = dpi
)
ggsave(paste0(path, "figures/Figure5.tiff"),
  figure5,
  width = 29.7 / scale_fig_b, height = 21 / scale_fig_b,
  compress = "lzw",
  dpi = dpi
)


# Figure 6 ----------------------------------------------------------------

figure6_elements <- list(
  aes(color = sample_size, shape = outcome_type, alpha = factor(true_effect)),
  geom_point(),
  scale_shape_manual(
    name = "Model Type",
    values = c(1, 3),
    labels = c(`linear` = "Linear", `binary` = "Logistic")
  ),
  scale_alpha_manual(
    name = "Null Hypothesis",
    values = c(0.15, 0.5),
    labels = c(`0` = "True", `1` = "False")
  ),
  scale_color_material_c(palette = "rainbow", name = "Sample Size"),
  theme_modern()
)


pd_rope <-
  df %>%
  ggplot(aes(x = p_direction, y = ROPE_full)) +
  figure6_elements +
  # geom_hline(yintercept = 0.05, linetype = "dashed") +
  # geom_vline(xintercept = 0.95, linetype = "dashed") +
  scale_x_continuous(
    breaks = c(seq(0.5, 1, length.out = 6)),
    labels = c("50%", "60%", "70%", "80%", "90%", "100%")
  ) +
  scale_y_continuous(
    breaks = c(seq(0, 1, length.out = 6)),
    labels = c("0", ".2", ".4", ".6", ".8", "1")
  ) +
  ylab("ROPE (full)") +
  xlab("Probability of Direction (pd)")

pd_bf <-
  df %>%
  ggplot(aes(x = p_direction, y = BF_ROPE_log)) +
  figure6_elements +
  geom_hline(yintercept = log(c(1 / 3, 3)), alpha = 0.15) +
  # geom_vline(xintercept = 0.95, linetype = "dashed") +
  scale_y_continuous(
    breaks = log(c(1 / 100, 1 / 30, 1 / 10, 1 / 3, 1, 3, 10, 30, 100)),
    labels = c("1/100", "1/30", "1/10", "1/3", "1", "3", "10", "30", "100")
  ) +
  scale_x_continuous(
    breaks = c(seq(0.5, 1, length.out = 6)),
    labels = c("50%", "60%", "70%", "80%", "90%", "100%")
  ) +
  ylab("Bayes factor (vs. ROPE)") +
  xlab("Probability of Direction (pd)") +
  coord_cartesian(ylim = log(c(1 / 30, 200)))

rope_bf <-
  df %>%
  ggplot(aes(x = ROPE_full, y = BF_ROPE_log)) +
  figure6_elements +
  geom_hline(yintercept = log(c(1 / 3, 3)), alpha = 0.15) +
  # geom_vline(xintercept = 0.05, linetype = "dashed") +
  scale_y_continuous(
    breaks = log(c(1 / 100, 1 / 30, 1 / 10, 1 / 3, 1, 3, 10, 30, 100)),
    labels = c("1/100", "1/30", "1/10", "1/3", "1", "3", "10", "30", "100")
  ) +
  scale_x_continuous(
    breaks = c(seq(0, 1, length.out = 6)),
    labels = c("0", ".2", ".4", ".6", ".8", "1")
  ) +
  ylab("Bayes factor (vs. ROPE)") +
  xlab("ROPE (full)") +
  coord_cartesian(ylim = log(c(1 / 30, 200)))

rainbow_legend <- get_legend(
  pd_rope + theme(legend.box.margin = margin(1, 1, 1, 1))
)

aligned_pd <- align_plots(
  pd_rope + theme(legend.position = "none", axis.title.x = element_blank()),
  pd_bf + theme(legend.position = "none"),
  align = "v"
)

figure6 <- plot_grid(
  aligned_pd[[1]],
  rainbow_legend,
  aligned_pd[[2]],
  rope_bf + theme(legend.position = "none", axis.title.y = element_blank()),
  nrow = 2
)


# figure 6
ggsave(paste0(path, "figures/Figure6.png"),
  figure6,
  width = 21 / scale_fig_b, height = 21 / scale_fig_b,
  dpi = dpi
)
ggsave(paste0(path, "figures/Figure6.tiff"),
  figure6,
  width = 21 / scale_fig_b, height = 21 / scale_fig_b,
  compress = "lzw",
  dpi = dpi
)








# Figure Performance (NOT INCLUDED) ------------------------------------------------------

# figure4 <- df_normalized %>%  # Or df_logodds
#   mutate(true_effect = forcats::fct_rev(true_effect),
#          Index = factor(Index, levels = c("p_value", "p_direction", "p_MAP", "ROPE_95", "ROPE_full", "BF_log", "BF_ROPE_log"))) %>%
#   ggplot(aes(x = Value, color = Index)) +
#   geom_line(stat="density", size = 1, key_glyph = "smooth", bw = "nrd", adjust = 2) +
#   # geom_density(geom="line", size = 1, key_glyph = "smooth") +
#   facet_grid(~true_effect,
#              labeller = as_labeller(c("Absence" = "Absence of Effect",
#                                       "Presence" = "Presence of Effect")),
#              switch = "x") +
#   theme_modern() +
#   scale_color_manual(values = c("p_value" = "#607D8B",
#                                 "p_direction" = "#2196F3",
#                                 "p_MAP" = "#3F51B5",
#                                 "ROPE_95" = "#FF9800",
#                                 "ROPE_full" = "#f44336",
#                                 "BF_log" = "#4CAF50",
#                                 "BF_ROPE_log" = "#CDDC39"),
#                      labels = indices) +
#   scale_x_continuous(breaks = c(seq(0, 1, length.out = 5)),
#                      labels = c("0", ".25", ".50", ".75", "1"),
#                      expand = c(0, 0)) +
#   scale_y_continuous(expand = c(0, 0)) +
#   theme(strip.placement = "outside",
#         legend.title = element_blank()) +
#   ylab("Density Probability Distribution") +
#   xlab("Normalized value")
#
# figure4
# ggsave(paste0(path, "figures/Figure3", figure_format),
#        figure4,
#        width = 29.7 / 3, height = 21 / 3, dpi = dpi
# )




# Other Junk -------------------------------------------------------------


# https://twitter.com/StanLazic/status/1162366953866125313?s=20
# p <- df %>%
#   ggplot(aes(x = p_MAP, y = BF_log)) +
#   figure6_elements +
#   geom_hline(yintercept = log(c(1 / 3, 3)), alpha = 0.15) +
#   # geom_vline(xintercept = 0.95, linetype = "dashed") +
#   scale_y_continuous(
#     breaks = log(c(1 / 100, 1 / 30, 1 / 10, 1 / 3, 1, 3, 10, 30, 100)),
#     labels = c("1/100", "1/30", "1/10", "1/3", "1", "3", "10", "30", "100")
#   ) +
#   ylab("log BF") +
#   xlab("MAP-based p-value") +
#   coord_cartesian(ylim = log(c(1 / 30, 200)))
#
# ggsave(paste0(path, "figures/temp", figure_format),
#        p,
#        width = 21 / 2, height = 21 / 2, dpi = dpi
# )
