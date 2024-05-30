skip_if_not_installed("flexdashboard")
skip_if_not_installed("DT")
skip_if(interactive(), "This test is not run in interactive mode")
skip_on_cran()

test_that("it generates HTML for supported models", {
  skip_on_covr()

  withr::with_tempdir(code = {
    mod <- lm(wt ~ mpg, mtcars)
    model_dashboard(mod, quiet = TRUE, browse_html = FALSE)
    expect_true(file.exists("easydashboard.html"))
  })
})

test_that("it doesn't fail for unsupported models", {
  skip_on_covr()

  withr::with_tempdir(code = {
    filename <- "myfile.html"
    model_dashboard(NULL, output_file = filename, quiet = TRUE, browse_html = FALSE)
    expect_true(file.exists(filename))
  })
})

test_that("it opens HTML in browser in interactive context", {
  skip_if_not_installed("mockery")
  skip_on_covr()

  withr::with_tempdir(code = {
    mockery::stub(easystats::model_dashboard, "utils::browseURL", NULL)

    expect_silent(model_dashboard(NULL, quiet = TRUE, browse_html = TRUE))
    expect_invisible(model_dashboard(NULL, quiet = TRUE, browse_html = FALSE))
  })
})
