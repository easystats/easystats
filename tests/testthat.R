if (require("testthat", quietly = TRUE)) {
  suppressPackageStartupMessages(library(easystats))
  test_check("easystats")
}
