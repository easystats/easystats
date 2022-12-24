test_that("it generates HTML for supported models", {
  withr::with_tempdir(code = {
    mod <- lm(wt ~ mpg, mtcars)
    model_dashboard(mod, quiet = TRUE)
    expect_true(file.exists("easydashboard.html"))
  })
})

test_that("it doesn't fail for unsupported models", {
  withr::with_tempdir(code = {
    filename <- "myfile.html"
    model_dashboard(NULL, output_file = filename, quiet = TRUE)
    expect_true(file.exists(filename))
  })
})
