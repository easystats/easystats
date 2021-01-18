library(bayestestR)
library(tidyverse)


# Load the rstanarm and the see package
library(rstanarm)
library(see)

# Fit a Bayesian linear regression
model <- stan_glm(Petal.Width ~ Petal.Length * Sepal.Width, data = iris)

# Store results
result_pd <- p_direction(model)

# Print and plot results
print(result_pd)
plot(result_pd)

# Save --------------------------------------------------------------------

x <- data_plot(pd(model))

p <- x %>%
  filter(y != "(Intercept)") %>%
  as.data.frame() %>%
  ggplot(aes(x = x, y = y, height = height, group = y, fill = fill)) +
  ggridges::geom_ridgeline_gradient(color = "white") +
  add_plot_attributes(x) +
  geom_vline(aes(xintercept = 0), linetype = "dotted") +
  theme_modern() +
  scale_fill_manual(values = c("Negative" = "#E91E63", "Positive" = "#4CAF50")) +
  theme(plot.title = element_text(hjust = 0.5))
p
ggsave("Figure4.png", plot = p, width = 13 * 0.7, height = 8 * 0.7, units = "in", dpi = 450)
