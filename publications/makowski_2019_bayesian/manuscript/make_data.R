library(dplyr)
library(tidyr)
library(effectsize)
library(parameters)
library(performance)
library(ggplot2)
library(see)



# Data Loading -----------------------------------------------------------------
path <- ""
df <- read.csv(paste0(path, "../data/data.csv"))
# df <- read.csv("https://raw.github.com/easystats/easystats/master/publications/makowski_2019_bayesian/data/data.csv")

# df <- df[seq(1,nrow(df), length.out = 3600),] # get every 10th line

# Normalization ----------------------------------------------------------------
df_normalized <- df %>%
  # Cap BFs at 999
  # mutate_at(vars("BF_log", "BF_ROPE_log"), function(x) ifelse(x >= log(999), NA, x)) %>%
  mutate_at(vars("BF_log", "BF_ROPE_log"), stats::plogis) %>%
  # Normalize all indices between 0 and 1
  effectsize::normalize(select = c("p_value", "p_direction", "p_MAP", "ROPE_95", "ROPE_full", "BF_log", "BF_ROPE_log")) %>%
  # Inverse BFs and pd so that higher value = higher evidence for effect
  mutate_at(vars("p_value", "p_MAP", "ROPE_95", "ROPE_full"), function(x) -1*x + 1) %>%
  # Reshape
  select(p_value, p_direction, p_MAP, ROPE_95, ROPE_full, BF_log, BF_ROPE_log, sample_size, outcome_type, error, true_effect) %>%
  tidyr::gather("Index", "Value", -sample_size, -outcome_type, -error, -true_effect) %>%
  mutate(true_effect = as.factor(ifelse(true_effect == 1, "Presence", "Absence")),
         true_effect = forcats::fct_relevel(true_effect, "Presence", "Absence"))


# Normalization ----------------------------------------------------------------
df_logodds <- df %>%
  mutate(p_direction = (p_direction - 0.5) * 2) %>% # prevent artifact due to pd not being bounded [0-1] but [0.5-1].
  mutate_at(vars("p_value", "p_direction", "p_MAP", "ROPE_95", "ROPE_full"), ~log(.x / (1-.x))) %>%
  filter_at(vars("p_value", "p_direction", "p_MAP", "ROPE_95", "ROPE_full"), ~!is.infinite(.x)) %>% # lose about 15% of observations...
  effectsize::normalize(select = c("p_value", "p_direction", "p_MAP", "ROPE_95", "ROPE_full", "BF_log", "BF_ROPE_log")) %>%
  mutate_at(vars("p_value", "p_MAP", "ROPE_95", "ROPE_full"), function(x) -1*x + 1) %>%
  select(p_value, p_direction, p_MAP, ROPE_95, ROPE_full, BF_log, BF_ROPE_log, sample_size, outcome_type, error, true_effect) %>%
  tidyr::gather("Index", "Value", -sample_size, -outcome_type, -error, -true_effect) %>%
  mutate(true_effect = as.factor(ifelse(true_effect == 1, "Presence", "Absence")),
         true_effect = forcats::fct_relevel(true_effect, "Presence", "Absence"))
