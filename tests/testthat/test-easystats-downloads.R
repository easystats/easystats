skip_if_not_installed("cranlogs")
skip_on_cran()

test_that("easystats_downloads returns correct structure", {
  skip_if_offline()

  # Get downloads - use a short time period to make test faster
  result <- easystats_downloads(from = "2024-01-01")

  # Check class
  expect_s3_class(result, "easystats_downloads")
  expect_s3_class(result, "data.frame")

  # Check column names
  expect_equal(colnames(result), c("Package", "Total", "Monthly"))

  # Check that we have all packages plus total row
  expect_gte(nrow(result), length(easystats_packages()) + 1)

  # Check that last row is Total
  expect_equal(result$Package[nrow(result)], "Total")

  # Check that Total row sums correctly
  total_row <- result[result$Package == "Total", ]
  package_rows <- result[result$Package != "Total", ]
  expect_equal(total_row$Total, sum(package_rows$Total))
})

test_that("easystats_downloads sorting works", {
  skip_if_offline()

  # Sort by package name
  result_pkg <- easystats_downloads(from = "2024-01-01", sort_by = "package")
  expect_true(is.unsorted(
    result_pkg$Package[1:(nrow(result_pkg) - 1)],
    na.rm = TRUE
  ))

  # Sort by total (default)
  result_total <- easystats_downloads(from = "2024-01-01", sort_by = "total")
  # Check that totals are in descending order (excluding the last "Total" row)
  totals <- result_total$Total[1:(nrow(result_total) - 1)]
  expect_true(all(diff(totals) <= 0))
})

test_that("easystats_downloads handles NULL sort_by", {
  skip_if_offline()

  result <- easystats_downloads(from = "2024-01-01", sort_by = NULL)
  expect_s3_class(result, "easystats_downloads")
  expect_s3_class(result, "data.frame")
})

test_that("easystats_downloads print methods work", {
  skip_if_offline()

  result <- easystats_downloads(from = "2024-01-01")

  # Test print method
  expect_output(print(result))

  # Test other print methods exist
  expect_no_error(print_md(result))
  expect_no_error(print_html(result))
  expect_no_error(display(result))
})

test_that("easystats_downloads formats numbers with thousand separators", {
  skip_if_offline()

  result <- easystats_downloads(from = "2024-01-01")

  # Capture printed output
  output <- capture.output(print(result))
  output_text <- paste(output, collapse = "\n")

  # Check that numbers are formatted with commas (for numbers >= 1000)
  # Only check if we have downloads > 1000
  if (any(result$Total >= 1000)) {
    expect_true(grepl(",", output_text))
  }
})
