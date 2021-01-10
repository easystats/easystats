library(tidyverse)
library(correlation)
library(see)



# Figure 1 ----------------------------------------------------------------

# Generate data
set.seed(333)
data <- bayestestR::simulate_correlation(n=200, r=0.05)
data$V2 <- data$V2 + effectsize::change_scale(data$V1, to=c(0, 2))^3

data <- dplyr::arrange(data, V2)

# Outliers
data$V2[c(150, 185)] <- c(max(data$V2)*1, max(data$V2)*1)
data$V2[c(1, 5, 10)] <- c(min(data$V2)*2, max(data$V2)*1, min(data$V2)*1.5)

# Rescale to match coef
data$V2 <- effectsize::change_scale(data$V2, to=c(0, 1))


# Correlation results
rez <- rbind(
  select(cor_test(data, "V1", "V2", method="Pearson"), r, CI_low, CI_high, Method),
  select(cor_test(data, "V1", "V2", method="Spearman"), r=rho, CI_low, CI_high, Method),
  select(cor_test(data, "V1", "V2", method="Kendall"), r=tau, CI_low, CI_high, Method),
  select(cor_test(data, "V1", "V2", method="biweight"), r, CI_low, CI_high, Method),
  select(cor_test(data, "V1", "V2", method="percentage"), r, CI_low, CI_high, Method),
  select(cor_test(data, "V1", "V2", method="distance", corrected=FALSE), r, CI_low, CI_high, Method),
  select(cor_test(data, "V1", "V2", method="shepherd"), r=rho, CI_low, CI_high, Method),
  mutate(select(cor_test(data, "V1", "V2", method="Pearson", bayesian=TRUE), r=rho, CI_low, CI_high), Method="Bayesian")
)

# Format correlation to match data input from scatter
rez <- rez %>%
  arrange(r) %>%
  mutate(Method=forcats::fct_reorder(as.factor(Method), r),
         V2 = r,
         x = stringr::str_remove_all(levels(ggplot2::cut_interval(data$V1, n=n())), "[\\(\\[\\]]")) %>%
  separate(x, into=c("low", "high"), sep = ",") %>%
  mutate(V1 = (as.numeric(high)+as.numeric(low))/2)

# Fill empty CIs
# rez[rez$Method=="Spearman", c("CI_low", "CI_high")] <- rep(rez[rez$Method=="Spearman", "r"], 2)
# rez[rez$Method=="Kendall", c("CI_low", "CI_high")] <- rep(rez[rez$Method=="Kendall", "r"], 2)


# Initialize plot
fig1 <- ggplot(data, aes(x=V1, y=V2)) +
  see::theme_modern() +
  theme(axis.title.x = element_blank(),
        axis.text.x = element_blank()) +
  ylab("Correlation Coefficient") +
  scale_colour_material_d("rainbow") +

  # rez plot
  geom_segment(data=rez, aes(xend = V1, yend = -Inf, colour=Method), size=20,alpha=0.6, key_glyph = "point") +
  # geom_bar(data=rez, aes(fill=Method), stat = "identity")
  geom_errorbar(data=rez,
                aes(ymin=CI_low, ymax=CI_high, colour=Method),
                size=1.5,
                width = 0.15,
                alpha=0.8,
                key_glyph = "point") +
  # geom_point(data=rez, aes(colour=Method), size=5, key_glyph = "point") +

  # Scatter
  geom_point2(size=3, alpha=0.7) +
  geom_smooth(method="lm", colour="black", alpha=0.1, se=FALSE) +
  guides(color = guide_legend(override.aes = list(size=5)))
fig1

ggsave("figure1.png", fig1, height = 6, width = see::golden_ratio(6), dpi = 300)










# Figure 2 ----------------------------------------------------------------

fig2 <- correlation(iris) %>%
  as.table() %>%
  plot()

ggsave("figure2.png", fig2, height = 5, width = see::golden_ratio(5), dpi = 300)


# Figure 3 ----------------------------------------------------------------

library(ggraph) # needs to be loaded

fig3 <- mtcars %>%
  correlation(partial = TRUE) %>%
  plot()

ggsave("figure3.png", fig3, height = 8, width = see::golden_ratio(8), dpi = 300)
