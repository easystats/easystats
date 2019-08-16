source("make_data.R")










# TABLE 1: Impact of sample size ------------------------------------------

table1 <- df_normalized %>%
  lm(Value ~ outcome_type / true_effect / Index / sample_size + error, data = .) %>%
  parameters::model_parameters() %>%
  filter(grepl("sample_size", Parameter)) %>%
  mutate(Coefficient = abs(Std_Coefficient),
         Type = ifelse(stringr::str_detect(Parameter, "outcome_typelinear"), "Linear", "Logistic"),
         True_Effect = ifelse(stringr::str_detect(Parameter, "true_effectPresence"), "Presence", "Absence"),
         Parameter = stringr::str_remove(Parameter, "true_effectPresence:|true_effectAbsence:"),
         Parameter = stringr::str_remove(Parameter, "outcome_typelinear:|outcome_typebinary:"),
         Parameter = stringr::str_remove(Parameter, "Index"),
         Parameter = stringr::str_remove(Parameter, ":sample_size")) %>%
  select(True_Effect, Type, Parameter, Coefficient) %>%
  split(list(.$True_Effect, .$Type)) %>%
  bind_cols() %>%
  dplyr::select(-starts_with("True_Effect"), -starts_with("Type"), -Parameter1, -Parameter2, -Parameter3)
  # arrange(True_Effect, Type, Coefficient)

# reorder columns and rows
table1 <- table1[c(5, 3, 4, 6, 7, 1, 2), c(1, 3, 2, 5, 4)]
colnames(table1) <- c(
  "Index",
  "Linear Model Presence of True Effect",
  "Linear Model Absence of True Effect",
  "Logistic Model Presence of True Effect",
  "Logistic Model Absence of True Effect"
)



# TABLE 2: Impact of Noise ------------------------------------------------

table2 <- df_normalized %>%
  filter(true_effect == "Presence") %>%
  lm(Value ~ outcome_type / Index / error + sample_size, data = .) %>%
  parameters::model_parameters() %>%
  filter(grepl("error", Parameter)) %>%
  mutate(Coefficient = abs(Std_Coefficient),
         Type = ifelse(stringr::str_detect(Parameter, "outcome_typelinear"), "Linear", "Logistic"),
         # True_Effect = ifelse(stringr::str_detect(Parameter, "true_effectPresence"), "Presence", "Absence"),
         Parameter = stringr::str_remove(Parameter, "true_effectPresence:|true_effectAbsence:"),
         Parameter = stringr::str_remove(Parameter, "outcome_typelinear:|outcome_typebinary:"),
         Parameter = stringr::str_remove(Parameter, "Index"),
         Parameter = stringr::str_remove(Parameter, ":error")) %>%
  select(Type, Parameter, Coefficient) %>%
  arrange(Type, Coefficient)



# TABLE 3: Comparison of performance --------------------------------------

data_table3 <- df_normalized

table3 <- data.frame()
for (model_type in c("linear", "binary")) {
  p_value <- data_table3 %>%
    filter(Index == "p_value",
           outcome_type == model_type) %>%
    glm(true_effect ~ Value + error + sample_size, data = ., family = "binomial")
  p_direction <- data_table3 %>%
    filter(Index == "p_direction",
           outcome_type == model_type) %>%
    glm(true_effect ~ Value + error + sample_size, data = ., family = "binomial")
  p_MAP <- data_table3 %>%
    filter(Index == "p_MAP",
           outcome_type == model_type) %>%
    glm(true_effect ~ Value + error + sample_size, data = ., family = "binomial")
  ROPE_95 <- data_table3 %>%
    filter(Index == "ROPE_95",
           outcome_type == model_type) %>%
    glm(true_effect ~ Value + error + sample_size, data = ., family = "binomial")
  ROPE_full <- data_table3 %>%
    filter(Index == "ROPE_full",
           outcome_type == model_type) %>%
    glm(true_effect ~ Value + error + sample_size, data = ., family = "binomial")
  BF_log <- data_table3 %>%
    filter(Index == "BF_log",
           outcome_type == model_type) %>%
    glm(true_effect ~ Value + error + sample_size, data = ., family = "binomial")
  BF_ROPE_log <- data_table3 %>%
    filter(Index == "BF_ROPE_log",
           outcome_type == model_type) %>%
    glm(true_effect ~ Value + error + sample_size, data = ., family = "binomial")

  table3 <- performance::compare_performance(p_value,
                                             p_direction,
                                             p_MAP,
                                             ROPE_95,
                                             ROPE_full,
                                             BF_log,
                                             BF_ROPE_log) %>%
    mutate(Model_Type = model_type) %>%
    rbind(table3, .)
}

table3 <- table3 %>%
  select(Model_Type, Model, AIC, BIC, R2_Tjur, RMSE, PCP) # Why compare_performance doesn't give me BFs anymore?
  # select(Model_Type, Model, AIC, BIC, R2_Tjur, RMSE, PCP, BF) %>%
  # mutate(BF_log = bayestestR:::.format_big_small(log(BF)),
  #        BF = bayestestR:::.format_big_small(BF))



# TABLE 4: Summary --------------------------------------------------------

# in the manuscript.
