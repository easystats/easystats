# Tests for issue #459: library(easystats, quietly = TRUE) should suppress messages

# Helper function to detach all easystats packages
detach_easystats <- function() {
  pkgs <- c(
    "easystats", "bayestestR", "correlation", "datawizard",
    "effectsize", "insight", "modelbased", "parameters",
    "performance", "report", "see"
  )
  for (pkg in pkgs) {
    pkg_name <- paste0("package:", pkg)
    if (pkg_name %in% search()) {
      try(detach(pkg_name, unload = TRUE), silent = TRUE)
    }
  }
}

test_that("easystats respects quietly = TRUE parameter", {
  detach_easystats()

  # Capture both stdout and stderr messages explicitly
  output <- capture.output(
    library(easystats, quietly = TRUE),
    type = "message",
   
  )

  # When quietly = TRUE, output should be empty
  expect_length(output, 0)

  detach_easystats()
})

test_that("easystats shows messages by default (without quietly)", {
  detach_easystats()

  # Capture messages when loading normally
  output <- capture.output(
    library(easystats),
    type = "message"
  )

  # Normal loading should show messages
  expect_gt(length(output), 0)

  # Check for expected content in messages
  expect_true(any(grepl("Attaching packages", paste(output, collapse = " "))))
  expect_true(any(grepl("easystats", paste(output, collapse = " "))))

  detach_easystats()
})
