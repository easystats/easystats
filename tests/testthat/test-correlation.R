test_that("CI columns removed when ci = FALSE", {
  x <- easytats::correlation(mtcars, ci = FALSE)
  expect_false(any(c("CI", "CI_low", "CI_high") %in% colnames(x)))
})