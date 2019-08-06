library(ggplot2)
library(dplyr)
library(tidyr)
library(see)
library(cowplot)
library(scales)

df <- read.csv("https://raw.github.com/easystats/easystats/master/publications/makowski_2019_bayesian/data/data.csv")


indices <- c(
  "p_value" = "p-value",
  "p_direction" = "p-direction",
  "p_MAP" = "p-MAP",
  "ROPE_95" = "ROPE (95%)",
  "ROPE_full" = "ROPE (full)",
  "BF_log" = "log BF (vs. 0)",
  "BF_ROPE_log" = "log BF (vs. ROPE)",

  "binary" = "Logistic Model",
  "linear" = "Linear Model",

  "0" = "Absence of Effect",
  "1" = "Presence of Effect"
)

p_2_lo <- function(x){
  x[x==0] <- min(x!=0)
  x[x==1] <- max(x!=1)
  log(x / (1 - x))
}

lo_2_p <- function(x) 1 / (1 + exp(x))

figure1_data <- df %>%
  select(outcome_type, true_effect, error, sample_size,
         p_value, p_direction, p_MAP, ROPE_95, ROPE_full, BF_log, BF_ROPE_log) %>%
  mutate_at(vars(p_value, p_direction, p_MAP, ROPE_95, ROPE_full), p_2_lo) %>%
  gather(index, value, -error, -sample_size, -true_effect, -outcome_type) %>%
  mutate(
    true_effect = as.factor(true_effect),
    index = factor(index, levels = c("p_value", "p_direction", "p_MAP", "ROPE_95", "ROPE_full", "BF_log", "BF_ROPE_log"))
  ) %>%
  mutate(temp = as.factor(cut(sample_size, 8, labels = FALSE))) %>%
  group_by(temp) %>%
  mutate(size_group = round(mean(sample_size))) %>%
  ungroup()

fig_1_elements <- list(
  aes(size_group, value,
      fill = true_effect,
      group = interaction(true_effect, size_group)),
  geom_boxplot(outlier.shape = NA),
  facet_grid( ~ outcome_type, scales = "free", labeller = as_labeller(indices)),
  scale_fill_manual(name = "Effect",
                    values = c(`0` = "#f44336", `1` = "#8BC34A"),
                    labels = c(`0` = "Absence of Effect", `1` = "Presence of Effect")),
  theme_modern(),
  theme(panel.grid.major.y = element_line(colour = "gray", linetype = "dashed"),
        legend.position = "bottom"),
  xlab("Group Size")
)

not_last_p <- list(
  theme(panel.grid.major.y = element_line(colour = "gray", linetype = "dashed"),
        axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        legend.position = "none"),
  xlab("")
)

not_first_p <- list(
  theme(panel.grid.major.y = element_line(colour = "gray", linetype = "dashed"),
        strip.background = element_blank(), strip.text = element_blank(),
        legend.position = "none")
)

figure1_pvalue <- figure1_data %>%
  filter(index == "p_value") %>%
  ggplot() +
  fig_1_elements +
  scale_y_continuous(breaks = p_2_lo(c(0.001, 0.01, 0.05, 0.1, 0.5, 0.9, 0.95, 0.99, 0.999)),
                     labels = c(0.001, 0.01, 0.05, 0.1, 0.5, 0.9, 0.95, 0.99, 0.999),
                     limits = p_2_lo(c(0.0001,0.9999))) +
  ylab("p-value")

figure1_pd <- figure1_data %>%
  filter(index == "p_direction") %>%
  ggplot() +
  fig_1_elements +
  scale_y_continuous(breaks = p_2_lo(c(0.001, 0.01, 0.05, 0.1, 0.5, 0.9, 0.95, 0.99, 0.999)),
                     labels = c(0.001, 0.01, 0.05, 0.1, 0.5, 0.9, 0.95, 0.99, 0.999),
                     limits = p_2_lo(c(0.5,0.9999))) +
  ylab("p-direction")


figure1_pmap <- figure1_data %>%
  filter(index == "p_MAP") %>%
  ggplot() +
  fig_1_elements +
  scale_y_continuous(breaks = p_2_lo(c(0.001, 0.01, 0.05, 0.1, 0.5, 0.9, 0.95, 0.99, 0.999)),
                     labels = c(0.001, 0.01, 0.05, 0.1, 0.5, 0.9, 0.95, 0.99, 0.999),
                     limits = p_2_lo(c(0.0001,0.9999))) +
  ylab("p-MAP")

figure1_ROPE_95 <- figure1_data %>%
  filter(index == "ROPE_95") %>%
  ggplot() +
  fig_1_elements +
  scale_y_continuous(breaks = p_2_lo(c(0.001, 0.01, 0.05, 0.1, 0.5, 0.9, 0.95, 0.99, 0.999)),
                     labels = c(0.001, 0.01, 0.05, 0.1, 0.5, 0.9, 0.95, 0.99, 0.999),
                     limits = p_2_lo(c(0.0001,0.9999))) +
  ylab("ROPE (95%)") +
  coord_cartesian(ylim = p_2_lo(c(0.001,0.8)))

figure1_ROPE_full <- figure1_data %>%
  filter(index == "ROPE_full") %>%
  ggplot() +
  fig_1_elements +
  scale_y_continuous(breaks = p_2_lo(c(0.001, 0.01, 0.05, 0.1, 0.5, 0.9, 0.95, 0.99, 0.999)),
                     labels = c(0.001, 0.01, 0.05, 0.1, 0.5, 0.9, 0.95, 0.99, 0.999),
                     limits = p_2_lo(c(0.0001,0.9999))) +
  ylab("ROPE (full)") +
  coord_cartesian(ylim = p_2_lo(c(0.001,0.8)))

figure1_BF <- figure1_data %>%
  filter(index == "BF_log") %>%
  ggplot() +
  fig_1_elements +
  scale_y_continuous(breaks = log(c(1/100,1/30,1/10,1/3,1,3,10,30,100)),
                     labels = c("1/100","1/30","1/10","1/3","1","3","10","30","100")) +
  ylab("Bayes factor") +
  coord_cartesian(ylim = log(c(1/10,300)))

figure1_BF_rope <- figure1_data %>%
  filter(index == "BF_ROPE_log") %>%
  ggplot() +
  fig_1_elements +
  scale_y_continuous(breaks = log(c(1/100,1/30,1/10,1/3,1,3,10,30,100)),
                     labels = c("1/100","1/30","1/10","1/3","1","3","10","30","100")) +
  ylab("Bayes factor (ROPE)") +
  coord_cartesian(ylim = log(c(1/30,300)))

figure1 <- plot_grid(
  figure1_pvalue + not_last_p,
  figure1_pd + not_last_p + not_first_p,
  figure1_pmap + not_first_p + not_last_p,
  figure1_ROPE_95 + not_first_p + not_last_p,
  figure1_ROPE_full + not_first_p + not_last_p,
  figure1_BF + not_first_p + not_last_p,
  figure1_BF_rope + not_first_p,
  align = "v",
  rel_heights = c(1.7,rep(1,times = 5),1.7),
  ncol = 1
)

legend <- get_legend(
  figure1_pvalue + theme(legend.box.margin = margin(1, 0, 1, 0))
)

figure1_w_leg <- plot_grid(figure1,legend,ncol = 1, rel_heights = c(7,0.5))
figure1_w_leg


