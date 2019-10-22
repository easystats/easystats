# Descriptives of results  -----------------------

result %>%
  group_by(N, Location) %>%
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

