library(dplyr)
library(tidyr)
library(ggplot2)
library(see)
library(cowplot)

df <- read.csv("publications/makowski_2019_bayesian/data/data.csv")
df <- df[seq(1,nrow(df), length.out = 3600),]


indices <- c(
  "p_value"     = "p-value",
  "p_direction" = "p-direction",
  "p_MAP"       = "p-MAP",
  "ROPE_95"     = "ROPE (95%)",
  "ROPE_full"   = "ROPE (full)",
  "BF_log"      = "Bayes factor (vs. 0)",
  "BF_ROPE_log" = "Bayes factor (vs. ROPE)",

  "binary" = "Logistic Model",
  "linear" = "Linear Model",

  "0" = "Absence of Effect",
  "1" = "Presence of Effect"
)

not_last_p <- list(
  theme(axis.title.x    = element_blank(),
        axis.text.x     = element_blank(),
        axis.ticks.x    = element_blank(),
        legend.position = "none"),
  xlab("")
)

not_first_p <- list(
  theme(strip.background = element_blank(), strip.text = element_blank(),
        legend.position = "none")
)

# Figure 1 ----------------------------------------------------------------

figure1_data <- df %>%
  select(outcome_type, true_effect, error, sample_size,
         p_value, p_direction, p_MAP,
         ROPE_95, ROPE_full,
         BF_log, BF_ROPE_log) %>%
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
      group = interaction(true_effect, size_group)),
  geom_boxplot(outlier.shape = NA),
  facet_grid( ~ outcome_type, scales = "free", labeller = as_labeller(indices)),
  scale_fill_manual(name = "Effect",
                    values = c(`0` = "#f44336", `1` = "#8BC34A"),
                    labels = c(`0` = "Absence of Effect", `1` = "Presence of Effect")),
  theme_modern(),
  theme(legend.position = "bottom"),
  xlab("Group Size")
)



figure1_pvalue <-
  figure1_data %>%
  filter(index == "p_value") %>%
  ggplot() +
  figure1_elements +
  geom_hline(yintercept = 0.05, linetype = "dashed") +
  scale_y_continuous(breaks = c(seq(0,1,length.out = 5),0.05)) +
  ylab("p-value")

figure1_pd <-
  figure1_data %>%
  filter(index == "p_direction") %>%
  ggplot() +
  figure1_elements +
  geom_hline(yintercept = 0.95, linetype = "dashed") +
  scale_y_continuous(breaks = c(seq(0.5,1,length.out = 6),0.95)) +
  ylab("p-direction")

figure1_pmap <-
  figure1_data %>%
  filter(index == "p_MAP") %>%
  ggplot() +
  figure1_elements +
  geom_hline(yintercept = 0.05, linetype = "dashed") +
  scale_y_continuous(breaks = c(seq(0,1,length.out = 5),0.05)) +
  ylab("p-MAP")

figure1_ROPE_95 <-
  figure1_data %>%
  filter(index == "ROPE_95") %>%
  ggplot() +
  figure1_elements +
  geom_hline(yintercept = 0.05, linetype = "dashed") +
  scale_y_continuous(breaks = c(seq(0,1,length.out = 6),0.05)) +
  ylab("ROPE (95%)")

figure1_ROPE_full <-
  figure1_data %>%
  filter(index == "ROPE_full") %>%
  ggplot() +
  figure1_elements +
  geom_hline(yintercept = 0.05, linetype = "dashed") +
  scale_y_continuous(breaks = c(seq(0,1,length.out = 6),0.05)) +
  ylab("ROPE (full)")

figure1_BF <-
  figure1_data %>%
  filter(index == "BF_log") %>%
  ggplot() +
  figure1_elements +
  geom_hline(yintercept = log(c(1/3,3)), linetype = "dashed") +
  scale_y_continuous(breaks = log(c(1/100,1/30,1/10,1/3,1,3,10,30,100)),
                     labels = c("1/100","1/30","1/10","1/3","1","3","10","30","100")) +
  ylab("Bayes factor (vs. 0)") +
  coord_cartesian(ylim = log(c(1/10,300)))

figure1_BF_rope <-
  figure1_data %>%
  filter(index == "BF_ROPE_log") %>%
  ggplot() +
  figure1_elements +
  geom_hline(yintercept = log(c(1/3,3)), linetype = "dashed") +
  scale_y_continuous(breaks = log(c(1/100,1/30,1/10,1/3,1,3,10,30,100)),
                     labels = c("1/100","1/30","1/10","1/3","1","3","10","30","100")) +
  ylab("Bayes factor (vs. ROPE)") +
  coord_cartesian(ylim = log(c(1/30,300)))

figure1_cow <- plot_grid(
  figure1_pvalue    + not_last_p,
  figure1_pd        + not_last_p + not_first_p,
  figure1_pmap      + not_last_p + not_first_p,
  figure1_ROPE_95   + not_last_p + not_first_p,
  figure1_ROPE_full + not_last_p + not_first_p,
  figure1_BF        + not_last_p + not_first_p,
  figure1_BF_rope   + not_first_p,
  align = "v",
  rel_heights = c(1.5,rep(1.2,times = 5),1.7),
  ncol = 1
)

effects_legend <- get_legend(
  figure1_pvalue + theme(legend.box.margin = margin(1, 0, 1, 0))
)

figure1_cow_w_leg <- plot_grid(figure1_cow,effects_legend,
                               ncol = 1, rel_heights = c(7,0.5))
# figure1_cow_w_leg

ggsave2("publications/makowski_2019_bayesian/manuscript/figures/Figure1.png",
       figure1_cow_w_leg, width = 21/2, height = 29.7/2, dpi = 100)


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
  mutate(error_group = ifelse(true_effect==0,"Only Noise",error_group))


figure2_elements <- list(
  aes(error_group, value, fill = true_effect),
  geom_boxplot(outlier.shape = NA),
  facet_grid( ~ outcome_type, scales = "free", labeller = as_labeller(indices)),
  scale_fill_manual(name = "Effect",
                    values = c(`0` = "#f44336", `1` = "#8BC34A"),
                    labels = c(`0` = "Absence of Effect", `1` = "Presence of Effect")),
  theme_modern(),
  theme(legend.position = "bottom"),
  xlab("Noise")
)

figure2_pvalue <-
  figure2_data %>%
  filter(index == "p_value") %>%
  ggplot() +
  figure2_elements +
  geom_hline(yintercept = 0.05, linetype = "dashed") +
  scale_y_continuous(breaks = c(seq(0,1,length.out = 5),0.05)) +
  ylab("p-value")

figure2_pd <-
  figure2_data %>%
  filter(index == "p_direction") %>%
  ggplot() +
  figure2_elements +
  geom_hline(yintercept = 0.95, linetype = "dashed") +
  scale_y_continuous(breaks = c(seq(0.5,1,length.out = 6),0.95)) +
  ylab("p-direction")

figure2_pmap <-
  figure2_data %>%
  filter(index == "p_MAP") %>%
  ggplot() +
  figure2_elements +
  geom_hline(yintercept = 0.05, linetype = "dashed") +
  scale_y_continuous(breaks = c(seq(0,1,length.out = 5),0.05)) +
  ylab("p-MAP")

figure2_ROPE_95 <-
  figure2_data %>%
  filter(index == "ROPE_95") %>%
  ggplot() +
  figure2_elements +
  geom_hline(yintercept = 0.05, linetype = "dashed") +
  scale_y_continuous(breaks = c(seq(0,1,length.out = 6),0.05)) +
  ylab("ROPE (95%)")

figure2_ROPE_full <-
  figure2_data %>%
  filter(index == "ROPE_full") %>%
  ggplot() +
  figure2_elements +
  geom_hline(yintercept = 0.05, linetype = "dashed") +
  scale_y_continuous(breaks = c(seq(0,1,length.out = 6),0.05)) +
  ylab("ROPE (full)")

figure2_BF <-
  figure2_data %>%
  filter(index == "BF_log") %>%
  ggplot() +
  figure2_elements +
  geom_hline(yintercept = log(c(1/3,3)), linetype = "dashed") +
  scale_y_continuous(breaks = log(c(1/100,1/30,1/10,1/3,1,3,10,30,100)),
                     labels = c("1/100","1/30","1/10","1/3","1","3","10","30","100")) +
  ylab("Bayes factor (vs. 0)") +
  coord_cartesian(ylim = log(c(1/10,10000000))) # too big?

figure2_BF_rope <-
  figure2_data %>%
  filter(index == "BF_ROPE_log") %>%
  ggplot() +
  figure2_elements +
  geom_hline(yintercept = log(c(1/3,3)), linetype = "dashed") +
  scale_y_continuous(breaks = log(c(1/100,1/30,1/10,1/3,1,3,10,30,100)),
                     labels = c("1/100","1/30","1/10","1/3","1","3","10","30","100")) +
  ylab("Bayes factor (vs. ROPE)") +
  coord_cartesian(ylim = log(c(1/30,1000000)))


figure2_cow <- plot_grid(
  figure2_pvalue    + not_last_p,
  figure2_pd        + not_last_p + not_first_p,
  figure2_pmap      + not_last_p + not_first_p,
  figure2_ROPE_95   + not_last_p + not_first_p,
  figure2_ROPE_full + not_last_p + not_first_p,
  figure2_BF        + not_last_p + not_first_p,
  figure2_BF_rope   + not_first_p,
  align = "v",
  rel_heights = c(1.5,rep(1.2,times = 5),1.7),
  ncol = 1
)

figure2_cow_w_leg <- plot_grid(figure2_cow,effects_legend,
                               ncol = 1, rel_heights = c(7,0.5))
# figure2_cow_w_leg

ggsave2("publications/makowski_2019_bayesian/manuscript/figures/Figure2.png",
        figure2_cow_w_leg, width = 21/2, height = 29.7/2, dpi = 100)



# Figure 3 ----------------------------------------------------------------

# figure3_alpha <- 0.025
figure3_alpha <- 0.1

figure3_data <- df %>%
  select(outcome_type, true_effect, error, sample_size, p_value, p_direction, p_MAP, ROPE_95, ROPE_full, BF_log, BF_ROPE_log) %>%
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
  aes(p_value, value, color = true_effect,shape = size_group),
  geom_point(alpha = figure3_alpha, stroke = 0, shape = 16),
  geom_vline(xintercept = 0.05, linetype = "dashed"),
  facet_grid( ~ outcome_type, scales = "free", labeller = as_labeller(indices)),
  scale_color_manual(name = "Effect",
                    values = c(`0` = "#f44336", `1` = "#8BC34A"),
                    labels = c(`0` = "Absence of Effect", `1` = "Presence of Effect")),
  scale_x_continuous(breaks = c(seq(0,1,length.out = 5),0.05)),
  theme_modern(),
  theme(legend.position = "bottom"),
  xlab("p-value")
)

figure3_pd <-
  figure3_data %>%
  filter(index == "p_direction") %>%
  ggplot() +
  figure3_elements +
  geom_rug(alpha = figure3_alpha, sides = "rt", data = filter(figure3_data, index == "p_direction", true_effect==0)) +
  geom_rug(alpha = figure3_alpha, sides = "lb", data = filter(figure3_data, index == "p_direction", true_effect==1)) +
  geom_hline(yintercept = 0.95, linetype = "dashed") +
  scale_y_continuous(breaks = c(seq(0.5,1,length.out = 6),0.95)) +
  ylab("p-direction")

figure3_pmap <-
  figure3_data %>%
  filter(index == "p_MAP") %>%
  ggplot() +
  figure3_elements +
  geom_rug(alpha = figure3_alpha, sides = "rt", data = filter(figure3_data, index == "p_MAP", true_effect==0)) +
  geom_rug(alpha = figure3_alpha, sides = "lb", data = filter(figure3_data, index == "p_MAP", true_effect==1)) +
  geom_hline(yintercept = 0.05, linetype = "dashed") +
  scale_y_continuous(breaks = c(seq(0,1,length.out = 5),0.05)) +
  ylab("p-MAP")

figure3_ROPE_95 <-
  figure3_data %>%
  filter(index == "ROPE_95") %>%
  ggplot() +
  figure3_elements +
  geom_rug(alpha = figure3_alpha, sides = "rt", data = filter(figure3_data, index == "ROPE_95", true_effect==0)) +
  geom_rug(alpha = figure3_alpha, sides = "lb", data = filter(figure3_data, index == "ROPE_95", true_effect==1)) +
  geom_hline(yintercept = 0.05, linetype = "dashed") +
  scale_y_continuous(breaks = c(seq(0,1,length.out = 6),0.05)) +
  ylab("ROPE (95%)")

figure3_ROPE_full <-
  figure3_data %>%
  filter(index == "ROPE_full") %>%
  ggplot() +
  figure3_elements +
  geom_rug(alpha = figure3_alpha, sides = "rt", data = filter(figure3_data, index == "ROPE_full", true_effect==0)) +
  geom_rug(alpha = figure3_alpha, sides = "lb", data = filter(figure3_data, index == "ROPE_full", true_effect==1)) +
  geom_hline(yintercept = 0.05, linetype = "dashed") +
  scale_y_continuous(breaks = c(seq(0,1,length.out = 6),0.05)) +
  ylab("ROPE (full)")

figure3_BF <-
  figure3_data %>%
  filter(index == "BF_log") %>%
  ggplot() +
  figure3_elements +
  geom_rug(alpha = figure3_alpha, sides = "rt", data = filter(figure3_data, index == "BF_log", true_effect==0)) +
  geom_rug(alpha = figure3_alpha, sides = "lb", data = filter(figure3_data, index == "BF_log", true_effect==1)) +
  geom_hline(yintercept = log(c(1/3,3)), linetype = "dashed") +
  scale_y_continuous(breaks = log(c(1/100,1/30,1/10,1/3,1,3,10,30,100)),
                     labels = c("1/100","1/30","1/10","1/3","1","3","10","30","100")) +
  ylab("Bayes factor (vs. 0)") +
  coord_cartesian(ylim = log(c(1/10,300)))

figure3_BF_rope <-
  figure3_data %>%
  filter(index == "BF_ROPE_log") %>%
  ggplot() +
  figure3_elements +
  geom_rug(alpha = figure3_alpha, sides = "rt", data = filter(figure3_data, index == "BF_ROPE_log", true_effect==0)) +
  geom_rug(alpha = figure3_alpha, sides = "lb", data = filter(figure3_data, index == "BF_ROPE_log", true_effect==1)) +
  geom_hline(yintercept = log(c(1/3,3)), linetype = "dashed") +
  scale_y_continuous(breaks = log(c(1/100,1/30,1/10,1/3,1,3,10,30,100)),
                     labels = c("1/100","1/30","1/10","1/3","1","3","10","30","100")) +
  ylab("Bayes factor (vs. ROPE)") +
  coord_cartesian(ylim = log(c(1/30,300)))

figure3_cow <- plot_grid(
  figure3_pd        + not_last_p,
  figure3_pmap      + not_last_p + not_first_p,
  figure3_ROPE_95   + not_last_p + not_first_p,
  figure3_ROPE_full + not_last_p + not_first_p,
  figure3_BF        + not_last_p + not_first_p,
  figure3_BF_rope   + not_first_p,
  align = "v",
  rel_heights = c(1.5,rep(1.2,times = 4),1.7),
  ncol = 1
)

figure3_cow_w_leg <- plot_grid(figure3_cow,effects_legend,
                               ncol = 1, rel_heights = c(7,0.5))
# figure3_cow_w_leg

ggsave2("publications/makowski_2019_bayesian/manuscript/figures/Figure3.png",
        figure3_cow_w_leg, width = 21/2, height = 29.7/2, dpi = 100)
