library(dplyr)
library(tidyr)
library(parameters)
library(performance)

if (!inherits(df,"data.frame")) {
  # df <- read.csv("https://raw.github.com/easystats/easystats/master/publications/makowski_2019_bayesian/data/data.csv")
  df <- read.csv("../data/data.csv")
}


table_data <- df %>%
  # # MSB: Uncomment these rows to convert all to same log-odds scales
  mutate(p_direction = (p_direction - 0.5) * 2) %>% # prevent artifact due to pd not being bounded [0-1] but [0.5-1].
  mutate_at(vars(p_value, p_direction, p_MAP, ROPE_95, ROPE_full), ~log(.x / (1-.x))) %>%
  filter_at(vars(p_value, p_direction, p_MAP, ROPE_95, ROPE_full), ~!is.infinite(.x)) %>% # lose about 15% of observations...
  parameters::normalize(select = c("p_value", "p_direction", "p_MAP", "ROPE_95", "ROPE_full", "BF_log", "BF_ROPE_log")) %>%
  select(p_value, p_direction, p_MAP, ROPE_95, ROPE_full, BF_log, BF_ROPE_log, sample_size, outcome_type, error, true_effect) %>%
  tidyr::gather("Index", "Value", -sample_size, -outcome_type, -error, -true_effect) %>%
  mutate(true_effect = as.factor(ifelse(true_effect == 1, "Presence", "Absence")),
         true_effect = forcats::fct_relevel(true_effect, "Presence", "Absence"))


# TABLE 1: Impact of sample size ------------------------------------------

# Linear Models
table_lm <- table_data %>%
  filter(outcome_type == "linear") %>%
  lm(Value ~ true_effect / Index / sample_size + error, data = .) %>%
  parameters::model_parameters() %>%
  mutate(Type = "Linear")

# Logistic Models
table_glm <- table_data %>%
  filter(outcome_type == "binary") %>%
  lm(Value ~ true_effect / Index / sample_size + error, data = .) %>%
  parameters::model_parameters() %>%
  mutate(Type = "Logistic")

table1 <- rbind(table_lm, table_glm) %>%
  filter(grepl("sample_size", Parameter)) %>%
  mutate(Coefficient = abs(Std_Coefficient),
         True_Effect = ifelse(stringr::str_detect(Parameter, "true_effectPresence"), "Presence", "Absence"),
         Parameter = stringr::str_remove(Parameter, "true_effectPresence:|true_effectAbsence:"),
         Parameter = stringr::str_remove(Parameter, "Index"),
         Parameter = stringr::str_remove(Parameter, ":sample_size")) %>%
  select(Type, True_Effect, Parameter, Coefficient) %>%
  arrange(Type, True_Effect, Coefficient)




# TABLE 2: Impact of Noise ------------------------------------------------

# Linear Models
table_lm <- table_data %>%
  filter(outcome_type == "linear",
         true_effect == "Presence") %>%
  lm(Value ~ Index / error + sample_size, data = .) %>%
  parameters::model_parameters() %>%
  mutate(Type = "Linear",
         Effect = ifelse(grepl("true_effectAbsence", Parameter), "Absence", "Presence"))

# Logistic Models
table_glm <- table_data %>%
  filter(outcome_type == "binary",
         true_effect == "Presence") %>%
  lm(Value ~ Index / error + sample_size, data = .) %>%
  parameters::model_parameters() %>%
  mutate(Type = "Logistic",
         Effect = ifelse(grepl("true_effectAbsence", Parameter), "Absence", "Presence"))


table2 <- rbind(table_lm, table_glm) %>%
  filter(grepl("error", Parameter)) %>%
  mutate(Coefficient = abs(Std_Coefficient),
         Parameter = stringr::str_remove(Parameter, "Index"),
         Parameter = stringr::str_remove(Parameter, ":true_effectAbsence:error|:true_effectPresence:error")) %>%
  select(Effect, Type, Parameter, Coefficient) %>%
  arrange(Effect, Type, Coefficient)




# TABLE 3: Comparison of performance --------------------------------------

table3 <- data.frame()
for (model_type in c("linear", "binary")) {
  p_value <- table_data %>%
    filter(Index == "p_value",
           outcome_type == model_type) %>%
    glm(true_effect ~ Value + error + sample_size, data = ., family = "binomial")
  p_direction <- table_data %>%
    filter(Index == "p_direction",
           outcome_type == model_type) %>%
    glm(true_effect ~ Value + error + sample_size, data = ., family = "binomial")
  p_MAP <- table_data %>%
    filter(Index == "p_MAP",
           outcome_type == model_type) %>%
    glm(true_effect ~ Value + error + sample_size, data = ., family = "binomial")
  ROPE_95 <- table_data %>%
    filter(Index == "ROPE_95",
           outcome_type == model_type) %>%
    glm(true_effect ~ Value + error + sample_size, data = ., family = "binomial")
  ROPE_full <- table_data %>%
    filter(Index == "ROPE_full",
           outcome_type == model_type) %>%
    glm(true_effect ~ Value + error + sample_size, data = ., family = "binomial")
  BF_log <- table_data %>%
    filter(Index == "BF_log",
           outcome_type == model_type) %>%
    glm(true_effect ~ Value + error + sample_size, data = ., family = "binomial")
  BF_ROPE_log <- table_data %>%
    filter(Index == "BF_ROPE_log",
           outcome_type == model_type) %>%
    glm(true_effect ~ Value + error + sample_size, data = ., family = "binomial")

  table3 <- performance::compare_performance(p_value,
                                             p_direction, p_MAP,
                                             ROPE_95, ROPE_full,
                                             BF_log, BF_ROPE_log) %>%
    mutate(Model_Type = model_type) %>%
    rbind(table3, .)
}

table3 <- table3 %>%
  select(Model_Type, Model, AIC, BIC, R2_Tjur, RMSE, PCP, BF) %>%
  mutate(BF_log = bayestestR:::.format_big_small(log(BF)),
         BF = bayestestR:::.format_big_small(BF))



# TABLE 4: Summary --------------------------------------------------------

# in the manuscript.
