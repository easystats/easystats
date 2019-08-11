library(dplyr)
library(tidyr)
library(ggplot2)
library(see)
library(cowplot)

# path <- "publications/makowski_2019_bayesian/manuscript/"
path <- "./"
df <- read.csv(paste0(path, "../data/data.csv"))
# df <- df[seq(1,nrow(df), length.out = 3600),]

df$outcome_type <- forcats::fct_rev(df$outcome_type)

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

figure1_data <- df %>%
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
  mutate(temp = as.factor(cut(sample_size, 8, labels = FALSE))) %>%
  group_by(temp) %>%
  mutate(size_group = round(mean(sample_size))) %>%
  ungroup()

figure1_elements <- list(
  aes(size_group, value,
    fill = true_effect,
    group = interaction(true_effect, size_group)
  ),
  geom_boxplot(outlier.shape = NA),
  facet_grid(~outcome_type, scales = "free", labeller = as_labeller(indices)),
  scale_fill_manual(
    name = NULL,
    values = c(`0` = "#E91E63", `1` = "#4CAF50"),
    labels = c(`0` = "Absence of Effect", `1` = "Presence of Effect")
  ),
  theme_modern(),
  theme(legend.position = "top"),
  xlab("Group Size")
)



figure1_pvalue <-
  figure1_data %>%
  filter(index == "p_value") %>%
  ggplot() +
  figure1_elements +
  geom_hline(yintercept = 0.05, linetype = "dashed") +
  scale_y_continuous(breaks = c(seq(0, 1, length.out = 6)),
                     labels = c("0", ".2", ".4", ".6", ".8", "1")) +
  ylab("p-value")

figure1_pd <-
  figure1_data %>%
  filter(index == "p_direction") %>%
  ggplot() +
  figure1_elements +
  # geom_hline(yintercept = 0.95, linetype = "dashed") +
  scale_y_continuous(breaks = c(seq(0.5, 1, length.out = 6)),
                     labels = c("50%", "60%", "70%", "80%", "90%", "100%")) +
  ylab("p-direction")

figure1_pmap <-
  figure1_data %>%
  filter(index == "p_MAP") %>%
  ggplot() +
  figure1_elements +
  # geom_hline(yintercept = 0.05, linetype = "dashed") +
  scale_y_continuous(breaks = c(seq(0, 1, length.out = 6)),
                     labels = c("0", ".2", ".4", ".6", ".8", "1")) +
  ylab("p-MAP")

figure1_ROPE_95 <-
  figure1_data %>%
  filter(index == "ROPE_95") %>%
  ggplot() +
  figure1_elements +
  # geom_hline(yintercept = 0.05, linetype = "dashed") +
  scale_y_continuous(breaks = c(seq(0, 1, length.out = 6)),
                     labels = c("0", ".2", ".4", ".6", ".8", "1")) +
  ylab("ROPE (95%)")

figure1_ROPE_full <-
  figure1_data %>%
  filter(index == "ROPE_full") %>%
  ggplot() +
  figure1_elements +
  # geom_hline(yintercept = 0.05, linetype = "dashed") +
  scale_y_continuous(breaks = c(seq(0, 1, length.out = 6)),
                     labels = c("0", ".2", ".4", ".6", ".8", "1")) +
  ylab("ROPE (full)")

figure1_BF <-
  figure1_data %>%
  filter(index == "BF_log") %>%
  ggplot() +
  figure1_elements +
  geom_hline(yintercept = log(c(1 / 3, 3)), linetype = "dashed") +
  scale_y_continuous(
    breaks = log(c(1 / 100, 1 / 30, 1 / 10, 1 / 3, 1, 3, 10, 30, 100)),
    labels = c("1/100", "1/30", "1/10", "1/3", "1", "3", "10", "30", "100")
  ) +
  ylab("Bayes factor (vs. 0)") +
  coord_cartesian(ylim = log(c(1 / 30, 300)))

figure1_BF_rope <-
  figure1_data %>%
  filter(index == "BF_ROPE_log") %>%
  ggplot() +
  figure1_elements +
  geom_hline(yintercept = log(c(1 / 3, 3)), linetype = "dashed") +
  scale_y_continuous(
    breaks = log(c(1 / 100, 1 / 30, 1 / 10, 1 / 3, 1, 3, 10, 30, 100)),
    labels = c("1/100", "1/30", "1/10", "1/3", "1", "3", "10", "30", "100")
  ) +
  ylab("Bayes factor (vs. ROPE)") +
  coord_cartesian(ylim = log(c(1 / 30, 300)))

figure1_cow <- plot_grid(
  figure1_pvalue + not_last_p,
  figure1_pd + not_last_p + not_first_p,
  figure1_pmap + not_last_p + not_first_p,
  figure1_ROPE_95 + not_last_p + not_first_p,
  figure1_ROPE_full + not_last_p + not_first_p,
  figure1_BF + not_last_p + not_first_p,
  figure1_BF_rope + not_first_p,
  align = "v",
  rel_heights = c(1.5, rep(1.2, times = 5), 1.7),
  ncol = 1
)

effects_legend <- get_legend(
  figure1_pvalue + theme(legend.box.margin = margin(1, 0, 1, 0))
)

figure1_cow_w_leg <- plot_grid(effects_legend, figure1_cow,
  ncol = 1, rel_heights = c(0.5, 7)
)
# figure1_cow_w_leg

ggsave(paste0(path, "figures/Figure1.png"),
  figure1_cow_w_leg,
  width = 21 / 2, height = 29.7 / 2, dpi = 100
)


# Figure 2 ----------------------------------------------------------------

figure2_data <- df %>%
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


figure2_elements <- list(
  aes(error_group, value, fill = true_effect),
  geom_boxplot(outlier.shape = NA),
  facet_grid(~outcome_type, scales = "free", labeller = as_labeller(indices)),
  scale_fill_manual(
    name = NULL,
    values = c(`0` = "#E91E63", `1` = "#4CAF50"),
    labels = c(`0` = "Absence of Effect", `1` = "Presence of Effect")
  ),
  theme_modern(),
  theme(legend.position = "top"),
  xlab("Noise")
)

figure2_pvalue <-
  figure2_data %>%
  filter(index == "p_value") %>%
  ggplot() +
  figure2_elements +
  geom_hline(yintercept = 0.05, linetype = "dashed") +
  scale_y_continuous(breaks = c(seq(0, 1, length.out = 6)),
                     labels = c("0", ".2", ".4", ".6", ".8", "1")) +
  ylab("p-value")

figure2_pd <-
  figure2_data %>%
  filter(index == "p_direction") %>%
  ggplot() +
  figure2_elements +
  # geom_hline(yintercept = 0.95, linetype = "dashed") +
  scale_y_continuous(breaks = c(seq(0.5, 1, length.out = 6)),
                     labels = c("50%", "60%", "70%", "80%", "90%", "100%")) +
  ylab("p-direction")

figure2_pmap <-
  figure2_data %>%
  filter(index == "p_MAP") %>%
  ggplot() +
  figure2_elements +
  # geom_hline(yintercept = 0.05, linetype = "dashed") +
  scale_y_continuous(breaks = c(seq(0, 1, length.out = 6)),
                     labels = c("0", ".2", ".4", ".6", ".8", "1")) +
  ylab("p-MAP")

figure2_ROPE_95 <-
  figure2_data %>%
  filter(index == "ROPE_95") %>%
  ggplot() +
  figure2_elements +
  # geom_hline(yintercept = 0.05, linetype = "dashed") +
  scale_y_continuous(breaks = c(seq(0, 1, length.out = 6)),
                     labels = c("0", ".2", ".4", ".6", ".8", "1")) +
  ylab("ROPE (95%)")

figure2_ROPE_full <-
  figure2_data %>%
  filter(index == "ROPE_full") %>%
  ggplot() +
  figure2_elements +
  # geom_hline(yintercept = 0.05, linetype = "dashed") +
  scale_y_continuous(breaks = c(seq(0, 1, length.out = 6)),
                     labels = c("0", ".2", ".4", ".6", ".8", "1")) +
  ylab("ROPE (full)")

figure2_BF <-
  figure2_data %>%
  filter(index == "BF_log") %>%
  ggplot() +
  figure2_elements +
  geom_hline(yintercept = log(c(1 / 3, 3)), linetype = "dashed") +
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
  figure2_elements +
  geom_hline(yintercept = log(c(1 / 3, 3)), linetype = "dashed") +
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

figure2_cow_w_leg <- plot_grid(effects_legend, figure2_cow,
  ncol = 1, rel_heights = c(0.5, 7)
)
# figure2_cow_w_leg

ggsave(paste0(path, "figures/Figure2.png"),
  figure2_cow_w_leg,
  width = 21 / 2, height = 29.7 / 2, dpi = 100
)



# Figure 3 ----------------------------------------------------------------

figure3_alpha <- 0.025

figure3_data <- df %>%
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

figure3_elements <- list(
  aes(p_value, value, color = true_effect, shape = size_group),
  geom_point(alpha = figure3_alpha, stroke = 0),
  geom_vline(xintercept = 0.05, linetype = "dashed"),
  facet_grid(~outcome_type, scales = "free", labeller = as_labeller(indices)),
  scale_color_manual(
    name = NULL,
    values = c(`0` = "#E91E63", `1` = "#4CAF50"),
    labels = c(`0` = "Absence of Effect", `1` = "Presence of Effect")
  ),
  scale_shape_manual(values = c(0:6, 8, 9), guide = FALSE),
  scale_x_continuous(breaks = c(seq(0, 1, length.out = 6), 0.05),
                     labels = c("0", ".2", ".4", ".6", ".8", "1", ".05")),
  theme_modern(),
  theme(legend.position = "top"),
  xlab("p-value")
)

figure3_pd <-
  figure3_data %>%
  filter(index == "p_direction") %>%
  ggplot() +
  figure3_elements +
  geom_rug(alpha = figure3_alpha, sides = "rt", data = filter(figure3_data, index == "p_direction", true_effect == 0)) +
  geom_rug(alpha = figure3_alpha, sides = "lb", data = filter(figure3_data, index == "p_direction", true_effect == 1)) +
  # geom_hline(yintercept = 0.95, linetype = "dashed") +
  scale_y_continuous(breaks = c(seq(0.5, 1, length.out = 6)),
                     labels = c("50%", "60%", "70%", "80%", "90%", "100%")) +
  ylab("p-direction")

figure3_pmap <-
  figure3_data %>%
  filter(index == "p_MAP") %>%
  ggplot() +
  figure3_elements +
  geom_rug(alpha = figure3_alpha, sides = "rt", data = filter(figure3_data, index == "p_MAP", true_effect == 0)) +
  geom_rug(alpha = figure3_alpha, sides = "lb", data = filter(figure3_data, index == "p_MAP", true_effect == 1)) +
  # geom_hline(yintercept = 0.05, linetype = "dashed") +
  scale_y_continuous(breaks = c(seq(0, 1, length.out = 6)),
                     labels = c("0", ".2", ".4", ".6", ".8", "1")) +
  ylab("p-MAP")

figure3_ROPE_95 <-
  figure3_data %>%
  filter(index == "ROPE_95") %>%
  ggplot() +
  figure3_elements +
  geom_rug(alpha = figure3_alpha, sides = "rt", data = filter(figure3_data, index == "ROPE_95", true_effect == 0)) +
  geom_rug(alpha = figure3_alpha, sides = "lb", data = filter(figure3_data, index == "ROPE_95", true_effect == 1)) +
  # geom_hline(yintercept = 0.05, linetype = "dashed") +
  scale_y_continuous(breaks = c(seq(0, 1, length.out = 6)),
                     labels = c("0", ".2", ".4", ".6", ".8", "1")) +
  ylab("ROPE (95%)")

figure3_ROPE_full <-
  figure3_data %>%
  filter(index == "ROPE_full") %>%
  ggplot() +
  figure3_elements +
  geom_rug(alpha = figure3_alpha, sides = "rt", data = filter(figure3_data, index == "ROPE_full", true_effect == 0)) +
  geom_rug(alpha = figure3_alpha, sides = "lb", data = filter(figure3_data, index == "ROPE_full", true_effect == 1)) +
  # geom_hline(yintercept = 0.05, linetype = "dashed") +
  scale_y_continuous(breaks = c(seq(0, 1, length.out = 6)),
                     labels = c("0", ".2", ".4", ".6", ".8", "1")) +
  ylab("ROPE (full)")

figure3_BF <-
  figure3_data %>%
  filter(index == "BF_log") %>%
  ggplot() +
  figure3_elements +
  geom_rug(alpha = figure3_alpha, sides = "rt", data = filter(figure3_data, index == "BF_log", true_effect == 0)) +
  geom_rug(alpha = figure3_alpha, sides = "lb", data = filter(figure3_data, index == "BF_log", true_effect == 1)) +
  geom_hline(yintercept = log(c(1 / 3, 3)), linetype = "dashed") +
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
  figure3_elements +
  geom_rug(alpha = figure3_alpha, sides = "rt", data = filter(figure3_data, index == "BF_ROPE_log", true_effect == 0)) +
  geom_rug(alpha = figure3_alpha, sides = "lb", data = filter(figure3_data, index == "BF_ROPE_log", true_effect == 1)) +
  geom_hline(yintercept = log(c(1 / 3, 3)), linetype = "dashed") +
  scale_y_continuous(
    breaks = log(c(1 / 100, 1 / 30, 1 / 10, 1 / 3, 1, 3, 10, 30, 100)),
    labels = c("1/100", "1/30", "1/10", "1/3", "1", "3", "10", "30", "100")
  ) +
  ylab("Bayes factor (vs. ROPE)") +
  coord_cartesian(ylim = log(c(1 / 30, 300)))

figure3_cow <- plot_grid(
  figure3_pd + not_last_p,
  figure3_pmap + not_last_p + not_first_p,
  figure3_ROPE_95 + not_last_p + not_first_p,
  figure3_ROPE_full + not_last_p + not_first_p,
  figure3_BF + not_last_p + not_first_p,
  figure3_BF_rope + not_first_p,
  align = "v",
  rel_heights = c(1.5, rep(1.2, times = 4), 1.7),
  ncol = 1
)

figure3_cow_w_leg <- plot_grid(effects_legend, figure3_cow,
  ncol = 1, rel_heights = c(0.5, 7)
)
# figure3_cow_w_leg

ggsave(paste0(path, "figures/Figure3.png"),
  figure3_cow_w_leg,
  width = 21 / 2, height = 29.7 / 2, dpi = 100
)


# Figure 4 ----------------------------------------------------------------

make_figure4 <- function(.data) {
  .data$level <- ifelse(.data$level == "n.s.", 0, 1)
  fit <- suppressWarnings(glm(level ~ value, data = .data, family = "binomial"))
  newdata <- data.frame(value = seq(min(.data$value), max(.data$value), length.out = 500))
  newdata$sig <- predict(fit, newdata = newdata, type = "response")
  newdata
}

figure4_data <- df %>%
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
  mutate(data = lapply(data, make_figure4)) %>%
  unnest() %>%
  ungroup() %>%
  mutate(
    threshold = factor(threshold, levels = c("sig_1", "sig_05", "sig_01", "sig_001")),
    index = factor(index, levels = c("p_direction", "p_MAP", "ROPE_95", "ROPE_full", "BF_log", "BF_ROPE_log"))
  )

figure4_elements <- list(
  aes(
    x = value, y = sig,
    linetype = threshold, color = outcome_type,
    group = interaction(outcome_type, threshold)
  ),
  geom_line(aes(color = outcome_type), size = 1),
  scale_y_continuous(breaks = seq(0, 1, length.out = 5)),
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

figure4_pd <-
  figure4_data %>%
  filter(index == "p_direction") %>%
  ggplot() +
  figure4_elements +
  # geom_vline(xintercept = 0.95, linetype = "dashed") +
  scale_x_continuous(breaks = c(0.9, 0.925, 0.95, 0.975, 1),
                     labels = c("90%", "92.5%", "95%", "97.5%", "100%")) +
  xlab("p-direction") +
  coord_cartesian(xlim = c(0.9, 1))

figure4_pmap <-
  figure4_data %>%
  filter(index == "p_MAP") %>%
  ggplot() +
  figure4_elements +
  # geom_vline(xintercept = 0.05, linetype = "dashed") +
  scale_x_continuous(breaks = seq(0, 0.4, length.out = 5),
                     labels = c("0", ".1", ".2", ".3", ".4")) +
  xlab("p-MAP") +
  coord_cartesian(xlim = c(0, 0.4))

figure4_ROPE_95 <-
  figure4_data %>%
  filter(index == "ROPE_95") %>%
  ggplot() +
  figure4_elements +
  # geom_vline(xintercept = 0.05, linetype = "dashed") +
  scale_x_continuous(breaks = seq(0, 0.4, length.out = 5),
                     labels = c("0", ".1", ".2", ".3", ".4")) +
  xlab("ROPE (95%)") +
  coord_cartesian(xlim = c(0, 0.4))

figure4_ROPE_full <-
  figure4_data %>%
  filter(index == "ROPE_full") %>%
  ggplot() +
  figure4_elements +
  # geom_vline(xintercept = 0.05, linetype = "dashed") +
  scale_x_continuous(breaks = seq(0, 0.4, length.out = 5),
                     labels = c("0", ".1", ".2", ".3", ".4")) +
  xlab("ROPE (full)") +
  coord_cartesian(xlim = c(0, 0.4))

figure4_BF <-
  figure4_data %>%
  filter(index == "BF_log") %>%
  ggplot() +
  figure4_elements +
  geom_vline(xintercept = log(c(1 / 3, 3)), linetype = "dashed") +
  scale_x_continuous(
    breaks = log(c(1 / 100, 1 / 30, 1 / 10, 1 / 3, 1, 3, 10, 30, 100)),
    labels = c("1/100", "1/30", "1/10", "1/3", "1", "3", "10", "30", "100")
  ) +
  xlab("Bayes factor (vs. 0)") +
  coord_cartesian(xlim = log(c(1 / 30, 300)))


figure4_BF_rope <-
  figure4_data %>%
  filter(index == "BF_ROPE_log") %>%
  ggplot() +
  figure4_elements +
  geom_vline(xintercept = log(c(1 / 3, 3)), linetype = "dashed") +
  scale_x_continuous(
    breaks = log(c(1 / 100, 1 / 30, 1 / 10, 1 / 3, 1, 3, 10, 30, 100)),
    labels = c("1/100", "1/30", "1/10", "1/3", "1", "3", "10", "30", "100")
  ) +
  xlab("Bayes factor (vs. ROPE)") +
  coord_cartesian(xlim = log(c(1 / 30, 300)))

figure4_cow <- plot_grid(
  figure4_pd + theme(legend.position = "none"),
  figure4_ROPE_95 + theme(legend.position = "none", axis.title.y = element_blank()),
  figure4_BF + theme(legend.position = "none", axis.title.y = element_blank()),
  figure4_pmap + theme(legend.position = "none", axis.title.y = element_blank()),
  figure4_ROPE_full + theme(legend.position = "none", axis.title.y = element_blank()),
  figure4_BF_rope + theme(legend.position = "none", axis.title.y = element_blank()),
  nrow = 2,
  align = "v"
)

sig_legend <- get_legend(
  figure4_pd + theme(legend.box.margin = margin(0, 1, 0, 1))
)

figure4_cow_w_leg <- plot_grid(figure4_cow, sig_legend,
  ncol = 2, rel_widths = c(8, 1)
)
# figure4_cow_w_leg

ggsave(paste0(path, "figures/Figure4.png"),
  figure4_cow_w_leg,
  width = 29.7 / 2, height = 21 / 2, dpi = 100
)


# Figure 5 ----------------------------------------------------------------

figure5_elements <- list(
  aes(color = sample_size, shape = outcome_type, alpha = factor(true_effect)),
  geom_point(),
  scale_shape_manual(
    name = "Model Type",
    values = c(1, 3),
    labels = c(`linear` = "Linear", `binary` = "Logistic")
  ),
  scale_alpha_manual(
    name = "Effect",
    values = c(0.15, 0.5),
    labels = c(`0` = "Absence", `1` = "Presence")
  ),
  scale_color_material_c(palette = "rainbow", name = "Sample Size"),
  theme_modern()
)


pd_rope <-
  df %>%
  ggplot(aes(x = p_direction, y = ROPE_full)) +
  figure5_elements +
  # geom_hline(yintercept = 0.05, linetype = "dashed") +
  # geom_vline(xintercept = 0.95, linetype = "dashed") +
  scale_x_continuous(breaks = c(seq(0.5, 1, length.out = 6)),
                     labels = c("50%", "60%", "70%", "80%", "90%", "100%")) +
  scale_y_continuous(breaks = c(seq(0, 1, length.out = 6)),
                     labels = c("0", ".2", ".4", ".6", ".8", "1")) +
  ylab("ROPE (full)") +
  xlab("Probability of Direction (pd)")

pd_bf <-
  df %>%
  ggplot(aes(x = p_direction, y = BF_ROPE_log)) +
  figure5_elements +
  geom_hline(yintercept = log(c(1 / 3, 3)), linetype = "dashed") +
  # geom_vline(xintercept = 0.95, linetype = "dashed") +
  scale_y_continuous(
    breaks = log(c(1 / 100, 1 / 30, 1 / 10, 1 / 3, 1, 3, 10, 30, 100)),
    labels = c("1/100", "1/30", "1/10", "1/3", "1", "3", "10", "30", "100")
  ) +
  scale_x_continuous(breaks = c(seq(0.5, 1, length.out = 6)),
                     labels = c("50%", "60%", "70%", "80%", "90%", "100%")) +
  ylab("log BF (vs. ROPE)") +
  xlab("Probability of Direction (pd)") +
  coord_cartesian(ylim = log(c(1 / 30, 200)))

rope_bf <-
  df %>%
  ggplot(aes(x = ROPE_full, y = BF_ROPE_log)) +
  figure5_elements +
  geom_hline(yintercept = log(c(1 / 3, 3)), linetype = "dashed") +
  # geom_vline(xintercept = 0.05, linetype = "dashed") +
  scale_y_continuous(
    breaks = log(c(1 / 100, 1 / 30, 1 / 10, 1 / 3, 1, 3, 10, 30, 100)),
    labels = c("1/100", "1/30", "1/10", "1/3", "1", "3", "10", "30", "100")
  ) +
  scale_x_continuous(breaks = c(seq(0, 1, length.out = 6)),
                     labels = c("0", ".2", ".4", ".6", ".8", "1")) +
  ylab("log BF (vs. ROPE)") +
  xlab("ROPE (full)") +
  coord_cartesian(ylim = log(c(1 / 30, 200)))

rainbow_legend <- get_legend(
  pd_rope + theme(legend.box.margin = margin(1, 1, 1, 1))
)

figure5_cow <- plot_grid(
  pd_rope + theme(legend.position = "none", axis.title.x = element_blank()),
  rainbow_legend,
  pd_bf + theme(legend.position = "none"),
  rope_bf + theme(legend.position = "none", axis.title.y = element_blank()),
  nrow = 2
)

ggsave(paste0(path, "figures/Figure5.png"),
  figure5_cow,
  width = 21 / 2, height = 21 / 2, dpi = 100
)

