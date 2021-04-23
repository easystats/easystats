# --------------------
library(performance)
library(lme4)
library(see)

# fig1 --------------------

model <- lmer(Reaction ~ Days + (Days | Subject), sleepstudy)
set.seed(123)
result1 <- plot(check_model(model))

ggplot2::ggsave("figure1.png", result1, height = 10, width = 8)

# fig2 ----------------------

data(iris)
lm1 <- lm(Sepal.Length ~ Species, data = iris)
lm2 <- lm(Sepal.Length ~ Species + Petal.Length, data = iris)
lm3 <- lm(Sepal.Length ~ Species * Sepal.Width, data = iris)
lm4 <- lm(Sepal.Length ~ Species * Sepal.Width + Petal.Length + Petal.Width, data = iris)
set.seed(123)
result2 <- plot(compare_performance(lm1, lm2, lm3, lm4))

ggplot2::ggsave("figure2.png", result2, height = 3, width = 3)
