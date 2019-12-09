library(rstanarm)
library(ggplot2)
library(gganimate)
library(dplyr)
library(tidyr)
library(transformr)
library(gifski)
library(see)
library(estimate)
library(magick)

set.seed(333)

data <- bayestestR::simulate_correlation(n=20, r=0.2)
vizmatrix <- estimate::visualisation_matrix(data["V2"])


priors <- data.frame()
posteriors <- data.frame()
params <- data.frame()
prediction <- data.frame()
raw_data <- data.frame()
for(i in 4:nrow(data)){
  print(i)

  current_data <- data[1:i,]
  current_data$Evidence <- i
  raw_data <- rbind(raw_data, current_data)

  model <- rstanarm::stan_glm(V1 ~ V2,
                              prior = normal(0, 0.2),
                              data=current_data,
                              refresh = 0,
                              iter=10000,
                              chains=4,
                              warmup=4000)
  posterior <- insight::get_parameters(model)$V2

  current_prediction <- estimate::estimate_link(model, length=50, data=vizmatrix, keep_draws=FALSE, draws=10)
  current_prediction$Evidence <- i
  prediction <- rbind(prediction, current_prediction)

  param <- bayestestR::describe_posterior(model, test=c("pd", "ROPE", "p_MAP"), rope_ci = 1)[2,]
  param$BF_null <- bayestestR::bayesfactor_parameters(model, verbose = FALSE)[2, "BF"]
  param$BF_ROPE <- bayestestR::bayesfactor_rope(model, verbose = FALSE)[2, "BF"]

  param$Max <- bayestestR::density_at(posterior, median(posterior), method="KernSmooth")
  param$Evidence <- i
  params <- rbind(params, param)

  posterior <- bayestestR::estimate_density(posterior, method="KernSmooth")
  posterior$Evidence <- i
  posteriors <- rbind(posteriors, posterior)

  prior <- bayestestR::estimate_density(bayestestR::distribution_normal(1000, 0, 0.2), method="KernSmooth")
  prior$Evidence <- i
  priors <- rbind(priors, prior)
}





p_posterior <- ggplot(posteriors, aes(x=x, y=y)) +
  geom_area(data=priors, fill="#2196F3", alpha=1) +
  geom_segment(x = 0 , y = 0, xend = 0, yend = max(priors$y), size=0.5, color="#3F51B5", linetype = "dashed") +
  geom_segment(data=params, aes(x = Median , y = 0, xend = Median, yend = Max, color=Evidence), size=0.5, linetype = "dashed") +
  geom_line(aes(color=Evidence), size=1.5) +
  geom_vline(xintercept=0.2, color="#E91E63", size=1) +
  scale_colour_gradient(low = "#FFC107", high = "#E91E63", guide = FALSE) +
  scale_x_continuous(breaks = scales::pretty_breaks(n = 7)) +
  scale_y_continuous(expand = c(0, 0)) +
  see::theme_modern() +
  xlab("Effect") +
  ylab("Probability") +
  theme(axis.ticks.y = element_blank(),
        axis.text.y = element_blank()) +
  coord_cartesian(xlim=c(-0.6, 0.6)) +
  gganimate::transition_time(Evidence) +
  # view_follow(fixed_y = TRUE)
anim_posterior <- animate(p_posterior, duration=nrow(data)/4, detail=1)
# anim_posterior
# gganimate::anim_save("evidence_accumulation.gif", anim_posterior)




p_significance <- params %>%
  select(Evidence, `p (direction)`=pd, `p (0)`=p_MAP, `p (ROPE)`=ROPE_Percentage, `BF (0)`=BF_null, `BF (ROPE)`=BF_ROPE) %>%
  tidyr::pivot_longer(cols=-Evidence, names_to = "Index", values_to = "Value") %>%
  mutate(Index = forcats::fct_relevel(Index, "p (direction)", "p (0)", "p (ROPE)", "BF (ROPE)", "BF (0)")) %>%
  ggplot(aes(x=Evidence, y=Value, color=Index, group=1)) +
  geom_line(size=1) +
  scale_color_manual(values = c("p (direction)"="#9C27B0", "p (0)"="#f44336", "p (ROPE)"="#FF5722", "BF (0)"="#4CAF50", "BF (ROPE)"="#CDDC39"), guide=FALSE) +
  facet_wrap(~Index, nrow=5, scales = "free") +
  ylab("") +
  xlab("Evidence (Sample Size)") +
  see::theme_modern()
  gganimate::transition_reveal(Evidence)
anim_significance <- animate(p_significance, duration=nrow(data)/4, detail=1)
# anim_significance
# gganimate::anim_save("evidence_accumulation.gif", anim_significance)





p_correlation <- ggplot(data=raw_data, aes(y=V1, x=V2)) +
  geom_point(size=3) +
  geom_ribbon(data=prediction, aes(ymin=CI_low, y=Median, ymax=CI_high, fill=Evidence), alpha=0.3) +
  geom_line(data=prediction, aes(y=Median, color=Evidence), size=1) +
  see::theme_modern() +
  xlab("Variable 1") +
  ylab("Variable 2") +
  scale_colour_gradient(low = "#FFC107", high = "#E91E63", guide = FALSE) +
  scale_fill_gradient(low = "#FFC107", high = "#E91E63", guide = FALSE) +
  gganimate::transition_time(Evidence) +
  labs(title = "Evidence (Sample Size): {frame_time}")
anim_correlation <- animate(p_correlation, duration=nrow(data)/4, detail=1)

# Final plot --------------------------------------------------------------

a <- magick::image_read(anim_correlation)
b <- magick::image_read(anim_posterior)
c <- magick::image_read(anim_significance)

final <- magick::image_append(c(a[1], b[1], c[1]))
for(i in 2:length(b)){
  combined <- magick::image_append(c(a[i], b[i], c[i]))
  final <- c(final, combined)
}

final
gganimate::anim_save("evidence_accumulation.gif", final)



# https://www.datanovia.com/en/blog/gganimate-how-to-create-plots-with-beautiful-animation-in-r/
