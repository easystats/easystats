test_that("it generates HTML for supported models", {
  withr::with_tempdir(code = {
    mod <- lm(wt ~ mpg, mtcars)
    model_dashboard(mod, quiet = TRUE, browse_html = FALSE)
    expect_true(file.exists("easydashboard.html"))
  })
})

test_that("it doesn't fail for unsupported models", {
  withr::with_tempdir(code = {
    filename <- "myfile.html"
    model_dashboard(NULL, output_file = filename, quiet = TRUE, browse_html = FALSE)
    expect_true(file.exists(filename))
  })
})

test_that("it opens HTML in browser in interactive context", {
  # you don't want to open the browser during testing for real,
  # so we need to use mock testing
  local_mocked_bindings(browse_mock_function = function(...) TRUE)

  withr::with_tempdir(code = {
    filename <- "myfile.html"
    model_dashboard(NULL, output_file = filename, quiet = TRUE, browse_html = TRUE)
    expect_true(file.exists(filename))
  })
})
