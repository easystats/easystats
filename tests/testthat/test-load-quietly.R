skip_if_not_installed("callr")

test_that("easystats respects quietly = TRUE", {
  out <- callr::r(function() {
    capture.output(library(easystats, quietly = TRUE), type = "message")
  })
  expect_length(out, 0L)
})

test_that("easystats respects verbose = FALSE", {
  out <- callr::r(function() {
    capture.output(library(easystats, verbose = FALSE), type = "message")
  })
  expect_length(out, 0L)
})

test_that("easystats shows startup message by default", {
  out <- callr::r(function() {
    capture.output(library(easystats), type = "message")
  })
  expect_gt(length(out), 0L)
  expect_true(any(grepl(
    "Attaching packages: easystats",
    paste(out, collapse = " "),
    fixed = TRUE
  )))
})

test_that("easystats.quiet option silences startup", {
  out <- callr::r(function() {
    options(easystats.quiet = TRUE)
    capture.output(library(easystats), type = "message")
  })
  expect_length(out, 0L)
})

test_that("EASYSTATS_QUIET=1 silences startup", {
  out <- callr::r(function() {
    Sys.setenv(EASYSTATS_QUIET = "1")
    capture.output(library(easystats), type = "message")
  })
  expect_length(out, 0L)
})
