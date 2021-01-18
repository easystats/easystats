library(tidyverse)
library(strengejacke)
library(easystats)
library(rstanarm)
library(ggridges)

theme_set(theme_sjplot())
load("Dataset.RData")

# Prior-Assumption ----
# - Fall Incidence (Outcome) in hospitals ~ 13%
prob_fall <- qlogis(.13)
prob_fall_scale <- 1

# scale = .5 (on linear scale) allows a variation of about
# an assumed range of fall incidents from ~ 8% to
# 19% (plogis(qlogis(.13) +/- .5)).

# scale = 1 (on linear scale) allows a variation of about
# an assumed range of fall incidents from ~ 5% to
# 29% (plogis(qlogis(.13) +/- 1)).


# Prior-Assumption ----
# - moderate dementia means 2fold, strong dementia 3,5fold higher odds of falling
#   (OR of 2 resp. 3.5 from other research findings - on the log-scale we get
#   approx. the location-values of .7 and 1.25)
prob_dem_mid <- log(2)
prob_dem_hi <- log(3.5)

set.seed(1207)

mf1 <-
  formula(
    fall_incidence ~ stay + age + mmse + cci_c + # cci instead of multimorb
      barthel_code + fall_risk + cam_score + sex + group + chemicalres
  )

m1 <- glm(
  mf1,
  data = d,
  family = binomial("logit")
)


# weakly informative priors -----------------------------

m2 <-
  stan_glm(
    mf1,
    data = d,
    family = binomial("logit"),
    refresh = 0,
    cores = 4
  )


# informative priors on dementia -----------------------------

m3 <-
  stan_glm(
    mf1,
    data = d,
    family = binomial("logit"),
    prior = normal(
      location = c(0, 0, prob_dem_mid, prob_dem_hi, 0, 0, 0, 0, 0, 0, 0),
      scale = NULL
    ),
    refresh = 0,
    cores = 4
  )


# informative priors on dementia and intercept (fall incidence) ---------------

m4 <-
  stan_glm(
    mf1,
    data = d,
    family = binomial("logit"),
    prior = normal(
      location = c(0, 0, prob_dem_mid, prob_dem_hi, 0, 0, 0, 0, 0, 0, 0),
      scale = NULL
    ),
    prior_intercept = normal(location = prob_fall, scale = prob_fall_scale, autoscale = F),
    refresh = 0,
    cores = 4
  )


# informative priors on dementia, including scale, and intercept --------

m5 <-
  stan_glm(
    mf1,
    data = d,
    family = binomial("logit"),
    prior = normal(
      location = c(0, 0, prob_dem_mid, prob_dem_hi, 0, 0, 0, 0, 0, 0, 0),
      scale = c(2.5, 2.5, log(5), log(5), 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5)
    ),
    prior_intercept = normal(location = prob_fall, scale = prob_fall_scale, autoscale = F),
    refresh = 0,
    cores = 4
  )


# informative priors on dementia, including smaller scale, and intercept -------

m6 <-
  stan_glm(
    mf1,
    data = d,
    family = binomial("logit"),
    prior = normal(
      location = c(0, 0, prob_dem_mid, prob_dem_hi, 0, 0, 0, 0, 0, 0, 0),
      scale = c(2.5, 2.5, log(2.5), log(2.5), 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5)
    ),
    prior_intercept = normal(location = prob_fall, scale = prob_fall_scale, autoscale = F),
    refresh = 0,
    cores = 4
  )



tab_model(m1, m2, m3, m4, m5, m6)

ps2 <- prior_summary(m2)
ps3 <- prior_summary(m3)
ps4 <- prior_summary(m4)
ps5 <- prior_summary(m5)
ps6 <- prior_summary(m6)

ps2$prior
ps3$prior
ps4$prior
ps5$prior
ps6$prior

p <- plot_model(m2, type = "diag")
m2_pp_data <- filter(p$data, Term == "mmse3")
ggplot(m2_pp_data, aes(x = Estimate, fill = Sample)) +
  geom_density(alpha = .4) +
  labs(y = NULL)

p <- plot_model(m3, type = "diag")
m3_pp_data <- filter(p$data, Term == "mmse3")
ggplot(m3_pp_data, aes(x = Estimate, fill = Sample)) +
  geom_density(alpha = .4) +
  labs(y = NULL)
summary(m3_pp_data$Estimate[m3_pp_data$Sample == "Posterior"])

p <- plot_model(m4, type = "diag")
m4_pp_data <- filter(p$data, Term == "mmse3")
ggplot(m4_pp_data, aes(x = Estimate, fill = Sample)) +
  geom_density(alpha = .4) +
  labs(y = NULL)
summary(m4_pp_data$Estimate[m4_pp_data$Sample == "Posterior"])

p <- plot_model(m5, type = "diag")
m5_pp_data <- filter(p$data, Term == "mmse3")
ggplot(m5_pp_data, aes(x = Estimate, fill = Sample)) +
  geom_density(alpha = .4) +
  labs(y = NULL)
summary(m5_pp_data$Estimate[m5_pp_data$Sample == "Posterior"])

p <- plot_model(m6, type = "diag")
m6_pp_data <- filter(p$data, Term == "mmse3")
ggplot(m6_pp_data, aes(x = Estimate, fill = Sample)) +
  geom_density(alpha = .4) +
  labs(y = NULL)
summary(m6_pp_data$Estimate[m6_pp_data$Sample == "Posterior"])

m2pd <- m2_pp_data
m3pd <- m3_pp_data
m4pd <- m4_pp_data
m5pd <- m5_pp_data
m6pd <- m6_pp_data

m2pd$Sample <- rec(m2pd$Sample, rec = "Posterior=Posterior (model 1);Prior=Prior (model 1)")
m3pd$Sample <- rec(m3pd$Sample, rec = "Posterior=Posterior (model 2);Prior=Prior (model 2)")
m4pd$Sample <- rec(m4pd$Sample, rec = "Posterior=Posterior (model 3);Prior=Prior (model 3)")
m5pd$Sample <- rec(m5pd$Sample, rec = "Posterior=Posterior (model 4);Prior=Prior (model 4)")
m6pd$Sample <- rec(m6pd$Sample, rec = "Posterior=Posterior (model 5);Prior=Prior (model 5)")

pp_data <- bind_rows(m2pd, m3pd, m4pd, m5pd, m6pd)
pp_data$Grp <- ifelse(grepl("^Prior", pp_data$Sample), "Prior", "Posterior")
pp_data$Fill <- gsub("(.*)\\((.*)\\)", "\\2", x = pp_data$Sample)


# stacked ploting ------------------------------------------

p <- ggplot(pp_data, aes(x = Estimate, fill = Fill)) +
  geom_density(alpha = .2) +
  labs(y = NULL) +
  facet_wrap(~Grp, ncol = 1)

p + scale_fill_metro()






# row-wise plotting ------------------------------

m2dens <- m2_pp_data %>%
  group_by(Sample) %>%
  nest() %>%
  mutate(dens = map(data, ~ estimate_density(.$Estimate))) %>%
  unnest(dens) %>%
  mutate(max = x[which.max(y)]) %>%
  ungroup() %>%
  rec(Sample, rec = "Posterior=Posterior (model 1);Prior=Prior (model 1)")

m3dens <- m3_pp_data %>%
  group_by(Sample) %>%
  nest() %>%
  mutate(dens = map(data, ~ estimate_density(.$Estimate))) %>%
  unnest(dens) %>%
  mutate(max = x[which.max(y)]) %>%
  ungroup() %>%
  rec(Sample, rec = "Posterior=Posterior (model 2);Prior=Prior (model 2)")

m4dens <- m4_pp_data %>%
  group_by(Sample) %>%
  nest() %>%
  mutate(dens = map(data, ~ estimate_density(.$Estimate))) %>%
  unnest(dens) %>%
  mutate(max = x[which.max(y)]) %>%
  ungroup() %>%
  rec(Sample, rec = "Posterior=Posterior (model 3);Prior=Prior (model 3)")

m5dens <- m5_pp_data %>%
  group_by(Sample) %>%
  nest() %>%
  mutate(dens = map(data, ~ estimate_density(.$Estimate))) %>%
  unnest(dens) %>%
  mutate(max = x[which.max(y)]) %>%
  ungroup() %>%
  rec(Sample, rec = "Posterior=Posterior (model 4);Prior=Prior (model 4)")

m6dens <- m6_pp_data %>%
  group_by(Sample) %>%
  nest() %>%
  mutate(dens = map(data, ~ estimate_density(.$Estimate))) %>%
  unnest(dens) %>%
  mutate(max = x[which.max(y)]) %>%
  ungroup() %>%
  rec(Sample, rec = "Posterior=Posterior (model 5);Prior=Prior (model 5)")

dens_all <- bind_rows(m2dens, m3dens, m4dens, m5dens, m6dens)
dens_all$Grp <- ifelse(grepl("^Prior", dens_all$Sample), "Prior", "Posterior")
dens_all$Sample <- factor(dens_all$Sample, levels = rev(unique(dens_all$Sample)))

ggplot(dens_all, aes(x = x, y = Sample_r, height = y)) +
  geom_ridgeline(fill = "#2980b9", color = NA) +
  facet_wrap(~Grp, scales = "free_y") +
  geom_point(aes(x = max), color = "yellow") +
  theme_abyss()
