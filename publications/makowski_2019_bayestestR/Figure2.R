library(bayestestR)
library(tidyverse)
library(strengejacke)  # What the hell is that ^^
library(ggplot2)

set.seed(123)
posterior <- distribution_chisquared(100, 3)
dat <- as.data.frame(density(posterior))

p1 <- dat %>% mutate(fill = ifelse(x < hdi(posterior)$CI_low, "low",
                     ifelse(x > hdi(posterior)$CI_high, "high", "middle"))) %>%
  ggplot(aes(x=x, y=y, fill=fill)) +
  geom_ribbon(aes(ymin=0, ymax=y)) +
  geom_vline(xintercept=0, linetype="dotted") +
  theme_classic(base_size = 20) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, .25)) +
  scale_fill_manual(values=c("high"="#FFC107", "low"="#FFC107", "middle"="#E91E63"), guide=FALSE) +
  annotate("text", x=2.5, y=.05, label="The 89% HDI", color="white", size=10) +
  xlab(NULL) +
  ylab("Probability Density\n")

# ggsave("paper/Figure2.png", width = 13, height = 8, units = "in", dpi = 300)


p2 <- dat %>% mutate(fill = ifelse(x < ci(posterior)$CI_low, "low",
                             ifelse(x > ci(posterior)$CI_high, "high", "middle"))) %>%
  ggplot(aes(x=x, y=y, fill=fill)) +
  geom_ribbon(aes(ymin=0, ymax=y)) +
  geom_vline(xintercept=0, linetype="dotted") +
  theme_classic(base_size = 20) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, .25)) +
  scale_fill_manual(values=c("high"="#FFC107", "low"="#FFC107", "middle"="#2196F3"), guide=FALSE) +
  annotate("text", x=2.9, y=.05, label="The 89% ETI", color="white", size=10) +
  xlab("\nParameter Value") +
  ylab("Probability Density\n")

p <- see::plots(p1, p2, tags = TRUE)

ggsave("Figure2.png", plot = p, width = 13, height = 8, units = "in", dpi = 450)
