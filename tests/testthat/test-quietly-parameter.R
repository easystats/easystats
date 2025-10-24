# Tests for issue #459: library(easystats, quietly = TRUE) should suppress messages

test_that("easystats respects quietly = TRUE parameter", {
  # Wrap detach in try() for robustness (Bot Suggestion #1)
  if ("package:easystats" %in% search()) {
    try(detach("package:easystats", unload = TRUE), silent = TRUE)
  }
  
  # Capture both stdout and stderr messages explicitly (Bot Suggestion #2)
  output <- capture.output(
    library(easystats, quietly = TRUE),
    type = "message",
    stdout = TRUE,  # Capture standard output
    stderr = TRUE   # Capture standard error
  )
  
  # When quietly = TRUE, output should be empty
  expect_length(output, 0)
  
  try(detach("package:easystats", unload = TRUE), silent = TRUE)
})

test_that("easystats shows messages by default (without quietly)", {
  # Wrap detach in try() for robustness (Bot Suggestion #3)
  if ("package:easystats" %in% search()) {
    try(detach("package:easystats", unload = TRUE), silent = TRUE)
  }
  
  # Capture messages when loading normally
  output <- capture.output(
    library(easystats),
    type = "message"
  )
  
  # Normal loading should show messages
  expect_gt(length(output), 0)
  
  # Split into separate checks for better specificity (Bot Suggestion #4)
  expect_true(any(grepl("Attaching packages", paste(output, collapse = " "))))
  expect_true(any(grepl("easystats", paste(output, collapse = " "))))
  
  try(detach("package:easystats", unload = TRUE), silent = TRUE)
})
