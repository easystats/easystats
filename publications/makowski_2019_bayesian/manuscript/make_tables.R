source("make_data.R")


ind_names <- c(
  "*p*-value",
  "*p*-direction",
  "*p*-MAP",
  "ROPE (95%)",
  "ROPE (full)",
  "Bayes factor (vs. 0)",
  "Bayes factor (vs. ROPE)"
)

# TABLE 1: Impact of sample size ------------------------------------------

model1 <- lm(Value ~ outcome_type / true_effect / Index / sample_size + error, data = df_normalized)
table1 <- model1 %>%
  parameters::model_parameters() %>%
  left_join(standardize_parameters(model1), by = "Parameter") %>%
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
  "Linear Models / Presence of Effect",
  "Linear Models / Absence of Effect",
  "Logistic Models / Presence of Effect",
  "Logistic Models / Absence of Effect"
)

table1$Index <- ind_names



# TABLE 2: Impact of Noise ------------------------------------------------

model2 <- lm(Value ~ outcome_type / Index / error + sample_size, data = filter(df_normalized, true_effect == "Presence"))
table2 <- model2 %>%
  parameters::model_parameters() %>%
  left_join(standardize_parameters(model2), by = "Parameter") %>%
  filter(grepl("error", Parameter)) %>%
  mutate(Coefficient = abs(Std_Coefficient),
         Type = ifelse(stringr::str_detect(Parameter, "outcome_typelinear"), "Linear", "Logistic"),
         # True_Effect = ifelse(stringr::str_detect(Parameter, "true_effectPresence"), "Presence", "Absence"),
         Parameter = stringr::str_remove(Parameter, "true_effectPresence:|true_effectAbsence:"),
         Parameter = stringr::str_remove(Parameter, "outcome_typelinear:|outcome_typebinary:"),
         Parameter = stringr::str_remove(Parameter, "Index"),
         Parameter = stringr::str_remove(Parameter, ":error")) %>%
  select(Type, Parameter, Coefficient) %>%
  split(.$Type) %>%
  bind_cols() %>%
  dplyr::select(-starts_with("Type"), -Parameter1)
  # arrange(Type, Coefficient)

# reorder columns and rows
table2 <- table2[c(5, 3, 4, 6, 7, 1, 2), ]
colnames(table2) <- c(
  "Index",
  "Linear Models / Presence of Effect",
  "Logistic Models / Presence of Effect"
)

table2$Index <- ind_names

# TABLE 3: Comparison of performance --------------------------------------

# data_table3 <- df_normalized
#
# table3 <- data.frame()
# for (model_type in c("linear", "binary")) {
#   p_value <- data_table3 %>%
#     filter(Index == "p_value",
#            outcome_type == model_type) %>%
#     glm(true_effect ~ Value + error + sample_size, data = ., family = "binomial")
#   p_direction <- data_table3 %>%
#     filter(Index == "p_direction",
#            outcome_type == model_type) %>%
#     glm(true_effect ~ Value + error + sample_size, data = ., family = "binomial")
#   p_MAP <- data_table3 %>%
#     filter(Index == "p_MAP",
#            outcome_type == model_type) %>%
#     glm(true_effect ~ Value + error + sample_size, data = ., family = "binomial")
#   ROPE_95 <- data_table3 %>%
#     filter(Index == "ROPE_95",
#            outcome_type == model_type) %>%
#     glm(true_effect ~ Value + error + sample_size, data = ., family = "binomial")
#   ROPE_full <- data_table3 %>%
#     filter(Index == "ROPE_full",
#            outcome_type == model_type) %>%
#     glm(true_effect ~ Value + error + sample_size, data = ., family = "binomial")
#   BF_log <- data_table3 %>%
#     filter(Index == "BF_log",
#            outcome_type == model_type) %>%
#     glm(true_effect ~ Value + error + sample_size, data = ., family = "binomial")
#   BF_ROPE_log <- data_table3 %>%
#     filter(Index == "BF_ROPE_log",
#            outcome_type == model_type) %>%
#     glm(true_effect ~ Value + error + sample_size, data = ., family = "binomial")
#
#   table3 <- performance::compare_performance(p_value,
#                                              p_direction,
#                                              p_MAP,
#                                              ROPE_95,
#                                              ROPE_full,
#                                              BF_log,
#                                              BF_ROPE_log) %>%
#     mutate(Model_Type = model_type) %>%
#     rbind(table3, .)
# }
#
# table3 <- table3 %>%
#   # select(Model_Type, Model, AIC, BIC, R2_Tjur, RMSE, PCP, BF) %>%
#   # mutate(BF_log = bayestestR:::.format_big_small(log(BF)),
#   #        BF = bayestestR:::.format_big_small(BF))



# TABLE 4: Summary --------------------------------------------------------

table3 <- rbind(
  data.frame(
    "Index" = "Probability of Direction (pd)",
    "Interpretation" = "Probability that an effect is of the same sign as the median's.",
    "Definition" = "Proportion of the posterior distribution of the same sign than the median's.",
    "Strengths" = "Straightforward computation and interpretation. Objective property of the posterior distribution. 1:1 correspondence with the frequentist p-value.",
    "Limitations" = "Limited information favoring the null hypothesis."
  ),
  data.frame(
    "Index" = "MAP-based p-value",
    "Interpretation" = "Relative odds of the presence of an effect against 0.",
    "Definition" = "Density value at 0 divided by the density value at the mode of the posterior distribution.",
    "Strengths" = "Straightforward computation. Objective property of the posterior distribution",
    "Limitations" = "Limited information favoring the null hypothesis. Relates on density approximation. Indirect relationship between mathematical definition and interpretation."
  ),
  data.frame(
    "Index" = "ROPE (95%)",
    "Interpretation" = "Probability that the credible effect values are not negligible.",
    "Definition" = "Proportion of the 95% CI inside of a range of values defined as the ROPE.",
    "Strengths" = "Provides information related to the practical relevance of the effects.",
    "Limitations" = "A ROPE range needs to be arbitrarily defined. Sensitive to the scale (the unit) of the predictors. Not sensitive to highly significant effects."
  ),
  data.frame(
    "Index" = "ROPE (full)",
    "Interpretation" = "Probability that the effect possible values are not negligible.",
    "Definition" = "Proportion of the posterior distribution inside of a range of values defined as the ROPE.",
    "Strengths" = "Provides information related to the practical relevance of the effects.",
    "Limitations" = "A ROPE range needs to be arbitrarily defined. Sensitive to the scale (the unit) of the predictors."
  ),
  data.frame(
    "Index" = "Bayes factor (vs. 0)",
    "Interpretation" = "The degree by which the probability mass has shifted away from or towards the null value, after observing the data.",
    "Definition" = "Ratio of the density of the null value between the posterior and the prior distributions.",
    "Strengths" = "An unbounded continuous measure of relative evidence. Allows statistically supporting the null hypothesis.",
    "Limitations" = "Sensitive to selection of prior distribution shape, location and scale."
  ),
  data.frame(
    "Index" = "Bayes factor (vs. ROPE)",
    "Interpretation" = "The degree by which the probability mass has into or outside of the null interval (ROPE), after observing the data.",
    "Definition" = "Ratio of the odds of the posterior vs the prior distribution falling inside of the range of values defined as the ROPE.",
    "Strengths" = "An unbounded continuous measure of relative evidence. Allows statistically supporting the null hypothesis. Compared to the BF (vs. 0), evidence is accumulated faster for the null when the null is true.",
    "Limitations" = "Sensitive to selection of prior distribution shape, location and scale. Additionally, a ROPE range needs to be arbitrarily defined, which is sensitive to the scale (the unit) of the predictors. "
  )
)
