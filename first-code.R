devtools::load_all()

easystats::b
library(devtools)
load_all()

# IC affichées
x1 <- correlation(mtcars[-2], method = "auto", bayesian = TRUE, ci = 0.95)
head(x1)

# IC masquées
x2 <- correlation(mtcars[-2], method = "auto", bayesian = TRUE, ci = FALSE)
head(x2)
