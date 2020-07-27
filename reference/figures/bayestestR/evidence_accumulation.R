library(rstanarm)
library(ggplot2)
library(gganimate)
library(dplyr)
library(tidyr)
library(transformr)
library(gifski)
library(bayestestR)
library(see)
library(estimate)  # Not yet on CRAN: https://github.com/easystats/estimate
library(magick)

set.seed(333)



true_effect <- 0.5
prior_width <- 0.333
max_n <- 10





# Run simulation ----------------------------------------------------------


data <- bayestestR::simulate_correlation(n=max_n, r=true_effect)
vizmatrix <- estimate::visualisation_matrix(data["V2"])

# Initialize empty dataframes
priors <- data.frame()
posteriors <- data.frame()
params <- data.frame()
prediction <- data.frame()
correlation_data <- data.frame()
for(i in 5:nrow(data)){
  print(i)

  # Get data
  current_data <- data[1:i,]
  current_data$Evidence <- i
  correlation_data <- rbind(correlation_data, current_data)

  # Model and make predictions
  model <- rstanarm::stan_glm(V1 ~ V2,
                              prior = normal(0, prior_width),
                              data=current_data,
                              refresh = 0,
                              iter=10000,
                              chains=4,
                              warmup=4000)


  current_prediction <- estimate::estimate_link(model, length=50, data=vizmatrix, keep_draws=FALSE, draws=10)
  current_prediction$Evidence <- i
  prediction <- rbind(prediction, current_prediction)

  # Parameters
  posterior <- insight::get_parameters(model)$V2
  param <- bayestestR::describe_posterior(model, test=c("pd", "ROPE", "p_MAP"), rope_ci = 1)[2,]
  param$BF_null <- bayestestR::bayesfactor_parameters(model, verbose = FALSE)[2, "BF"]
  param$BF_ROPE <- bayestestR::bayesfactor_rope(model, verbose = FALSE)[2, "BF"]

  param$Max <- bayestestR::density_at(posterior, median(posterior), method="KernSmooth")
  param$Evidence <- i
  params <- rbind(params, param)

  # Prior and posterior
  posterior <- bayestestR::estimate_density(posterior, method="KernSmooth")
  posterior$Evidence <- i
  posteriors <- rbind(posteriors, posterior)

  prior <- bayestestR::estimate_density(bayestestR::distribution_normal(1000, 0, prior_width), method="KernSmooth")
  prior$Evidence <- i
  priors <- rbind(priors, prior)
}




# Make Figures ------------------------------------------------------------


p_correlation <- correlation_data %>%
  ggplot(aes(y=V1, x=V2)) +
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




p_posterior <- posteriors %>%
  ggplot(aes(x=x, y=y)) +
  geom_area(data=priors, fill="#2196F3", alpha=1) +
  geom_segment(x = 0 , y = 0, xend = 0, yend = max(priors$y), size=0.5, color="#3F51B5", linetype = "dashed") +
  geom_segment(data=params, aes(x = Median , y = 0, xend = Median, yend = Max, color=Evidence), size=0.5, linetype = "dashed") +
  geom_line(aes(color=Evidence), size=1.5) +
  geom_vline(xintercept=true_effect, color="#E91E63", size=1) +
  scale_colour_gradient(low = "#FFC107", high = "#E91E63", guide = FALSE) +
  annotate("segment", x = 0.05, xend = true_effect, y = 1.25, yend = 1.25, colour = "#E91E63", size=1, arrow=arrow(length = unit(0.10, "inches"), type="closed")) +
  annotate("text", x = 0, y = 1.25, hjust = 1, colour = "#E91E63", label="True effect") +
  annotate("segment", x = -0.7, xend = -prior_width, y = 0.75, yend = 0.75, colour = "#2196F3", size=1, arrow=arrow(length = unit(0.10, "inches"), type="closed")) +
  annotate("text", x = -0.75, y = 0.75, hjust = 1, colour = "#2196F3", label="Prior") +
  scale_x_continuous(breaks = scales::pretty_breaks(n = 7)) +
  scale_y_continuous(expand = c(0, 0)) +
  see::theme_modern() +
  xlab("Effect") +
  ylab("Probability") +
  theme(axis.ticks.y = element_blank(),
        axis.text.y = element_blank()) +
  coord_cartesian(xlim=c(-1, 1)) +
  gganimate::transition_time(Evidence)





p_significance <- params %>%
  select(Evidence, `p (direction)`=pd, `p (0)`=p_MAP, `p (ROPE)`=ROPE_Percentage, `BF (0)`=BF_null, `BF (ROPE)`=BF_ROPE) %>%
  tidyr::pivot_longer(cols=-Evidence, names_to = "Index", values_to = "Value") %>%
  mutate(Index = forcats::fct_relevel(Index, "p (direction)", "p (0)", "p (ROPE)", "BF (ROPE)", "BF (0)")) %>%
  ggplot(aes(x=Evidence, y=Value, color=Index, group=1)) +
  geom_line(size=2) +
  scale_color_manual(values = c("p (direction)"="#9C27B0", "p (0)"="#f44336", "p (ROPE)"="#FFC107", "BF (0)"="#4CAF50", "BF (ROPE)"="#CDDC39"), guide=FALSE) +
  facet_wrap(~Index, nrow=5, scales = "free") +
  ylab("") +
  xlab("Evidence (Sample Size)") +
  see::theme_modern() +
  gganimate::transition_reveal(Evidence)






# Final plot --------------------------------------------------------------
p1 <- magick::image_read(animate(p_correlation, duration=nrow(data)/4, fps=20))
p2 <- magick::image_read(animate(p_posterior, duration=nrow(data)/4, fps=20))
p3 <- magick::image_read(animate(p_significance, duration=nrow(data)/4, fps=20))

final <- magick::image_append(c(p1[1], p2[1], p3[1]))
for(i in 2:length(p2)){
  combined <- magick::image_append(c(p1[i], p2[i], p3[i]))
  final <- c(final, combined)
}

# Save final
gganimate::anim_save("evidence_accumulation.gif", final)

