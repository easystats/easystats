# Descriptives of results  -----------------------

result$Scale <- factor(result$Scale)
levels(result$Scale) <- c("narrow prior scale", "medium prior scale", "wide prior scale", "ultrawide prior scale")

result %>%
  group_by(N, Location, Scale) %>%
  summarise(
    Estimate = mean(Median),
    CI_low = mean(HDI_low),
    CI_high = mean(HDI_high)
  ) %>%
  print(n = 200)


result %>%
  group_by(N) %>%
  summarise(
    Estimate = mean(Coefficient),
    SE = mean(SE)
  ) %>%
  print(n = 200)




result %>%
  group_by(N, Location, Scale) %>%
  filter(N == 200) %>%
  summarise(
    Estimate = mean(Median),
    CI_low = mean(HDI_low),
    CI_high = mean(HDI_high)
  ) %>%
  print(n = 200)

