# library(dplyr)
# library(tidyr)
# library(parameters)
# library(performance)

# df <- read.csv("https://raw.github.com/easystats/easystats/master/publications/makowski_2019_bayesian/data/data.csv")
# df <- read.csv("../data/data.csv")
# df <- df[seq(1,nrow(df), length.out = 3600),] # get every 10th line




# TABLE 1: Impact of sample size ------------------------------------------

data <- df %>%
  parameters::normalize(select = c("p_value", "p_direction", "p_MAP", "ROPE_95", "ROPE_full", "BF_log", "BF_ROPE_log")) %>%
  select(p_value, p_direction, p_MAP, ROPE_95, ROPE_full, BF_log, BF_ROPE_log, sample_size, outcome_type, error, true_effect) %>%
  tidyr::gather("Index", "Value", -sample_size, -outcome_type, -error, -true_effect) %>%
  mutate(true_effect = as.factor(ifelse(true_effect == 1, "Presence", "Absence")),
         true_effect = forcats::fct_relevel(true_effect, "Presence", "Absence"))


# Linear Models
table_lm <- lm(Value ~ Index / sample_size + error, data = filter(data, outcome_type == "linear")) %>%
  parameters::model_parameters() %>%
  mutate(Type = "Linear")

# Logistic Models
table_glm <- lm(Value ~ Index / sample_size + error, data = filter(data, outcome_type == "binary")) %>%
  parameters::model_parameters() %>%
  mutate(Type = "Logistic")

table1 <- rbind(table_lm, table_glm) %>%
  filter(grepl("sample_size", Parameter)) %>%
  mutate(Coefficient = abs(Std_Coefficient),
         Parameter = stringr::str_remove(Parameter, "Index"),
         Parameter = stringr::str_remove(Parameter, ":sample_size")) %>%
  select(Type, Parameter, Coefficient) %>%
  arrange(Type, Coefficient)




# TABLE 2: Impact of Noise ------------------------------------------------

# Linear Models
table_lm <- lm(Value ~ Index / true_effect / error + sample_size, data = filter(data, outcome_type == "linear")) %>%
  parameters::model_parameters() %>%
  mutate(Type = "Linear",
         Effect = ifelse(grepl("true_effectAbsence", Parameter), "Absence", "Presence"))

# Logistic Models
table_glm <- lm(Value ~ Index / true_effect / error + sample_size, data = filter(data, outcome_type == "binary")) %>%
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
  p_value <- df %>%
    parameters::normalize(select = "p_value") %>%
    mutate(p_value = 1 - p_value) %>%
    filter(outcome_type == model_type) %>%
    glm(true_effect ~ p_value + error + sample_size, data = ., family = "binomial")
  p_direction <- df %>%
    parameters::normalize(select = "p_direction") %>%
    filter(outcome_type == model_type) %>%
    glm(true_effect ~ p_direction + error + sample_size, data = ., family = "binomial")
  p_MAP <- df %>%
    parameters::normalize(select = "p_MAP") %>%
    mutate(p_MAP = 1 - p_MAP) %>%
    filter(outcome_type == model_type) %>%
    glm(true_effect ~ p_MAP + error + sample_size, data = ., family = "binomial")
  ROPE_95 <- df %>%
    parameters::normalize(select = "ROPE_95") %>%
    mutate(ROPE_95 = 1 - ROPE_95) %>%
    filter(outcome_type == model_type) %>%
    glm(true_effect ~ ROPE_95 + error + sample_size, data = ., family = "binomial")
  ROPE_full <- df %>%
    parameters::normalize(select = "ROPE_full") %>%
    mutate(ROPE_full = 1 - ROPE_full) %>%
    filter(outcome_type == model_type) %>%
    glm(true_effect ~ ROPE_full + error + sample_size, data = ., family = "binomial")
  BF_log <- df %>%
    parameters::normalize(select = "BF_log") %>%
    filter(outcome_type == model_type) %>%
    glm(true_effect ~ BF_log + error + sample_size, data = ., family = "binomial")
  BF_ROPE_log <- df %>%
    parameters::normalize(select = "BF_ROPE_log") %>%
    filter(outcome_type == model_type) %>%
    glm(true_effect ~ BF_ROPE_log + error + sample_size, data = ., family = "binomial")

  performance_table <- performance::compare_performance(p_value, p_direction, p_MAP, ROPE_95, ROPE_full, BF_log, BF_ROPE_log)
  performance_table <- cbind(data.frame(Model_Type = model_type), performance_table)
  table3 <- rbind(table3, performance_table)
}

table3 <- table3 %>%
  select(Model_Type, Model, AIC, BIC, R2_Tjur, RMSE, LOGLOSS, PCP, BF) %>%
  mutate(BF_log = bayestestR:::.format_big_small(log(BF)),
         BF = bayestestR:::.format_big_small(BF))



# TABLE 4: Summary --------------------------------------------------------

# in the manuscript.
