skip_if_not_installed("jsonlite")

test_that("install_latest() updates only requested packages that are behind", {
  installed <- list()

  mock_versions <- function(cran_versions = rep("1.0.0", 11)) {
    pkgs <- easystats_packages()
    data.frame(
      package = pkgs,
      cran = cran_versions,
      local = rep("1.0.0", length(pkgs)),
      behind = rep(FALSE, length(pkgs)),
      stringsAsFactors = FALSE
    )
  }

  local_mocked_bindings(
    .easystats_version = function() mock_versions()
  )
  local_mocked_bindings(
    fromJSON = function(url) {
      if (grepl("insight$", url)) {
        list(Version = "2.0.0")
      } else {
        list(Version = "1.0.0")
      }
    },
    .package = "jsonlite"
  )
  local_mocked_bindings(
    install.packages = function(pkgs, ...) {
      installed[[length(installed) + 1L]] <<- pkgs
      invisible(NULL)
    },
    .package = "utils"
  )

  install_latest(packages = "insight", verbose = FALSE)
  expect_identical(installed[[1L]], "insight")

  install_latest(packages = c("insight", "parameters"), verbose = FALSE)
  expect_identical(installed[[2L]], "insight")

  install_latest(packages = c("parameters", "insight"), verbose = FALSE)
  expect_identical(installed[[3L]], "insight")
})

test_that("install_latest() verbose output and NA CRAN versions only reflect requested packages", {
  installed <- NULL
  pkgs <- easystats_packages()
  cran_versions <- rep(NA_character_, length(pkgs))
  cran_versions[pkgs == "performance"] <- "9.9.9"

  local_mocked_bindings(
    .easystats_version = function() {
      data.frame(
        package = pkgs,
        cran = cran_versions,
        local = rep("1.0.0", length(pkgs)),
        behind = pkgs == "performance",
        stringsAsFactors = FALSE
      )
    }
  )
  local_mocked_bindings(
    fromJSON = function(url) list(Version = "2.0.0"),
    .package = "jsonlite"
  )
  local_mocked_bindings(
    install.packages = function(pkgs, ...) {
      installed <<- pkgs
      invisible(NULL)
    },
    .package = "utils"
  )

  out <- capture.output(install_latest(packages = "insight", verbose = TRUE))
  expect_identical(installed, "insight")
  expect_true(any(grepl("insight", out, fixed = TRUE)))
  expect_false(any(grepl("performance", out, fixed = TRUE)))
})
