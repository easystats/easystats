
library(here)
library(magrittr)
library(fs)
library(purrr)

home_dir <- here::dr_here()

common_root <- here::here("Documents", "GitHub")

pkg_with_change <- "datawizard"
pkg_without_change <- easystats:::.packages_on_cran() %>% setdiff(pkg_with_change)

copy_from_folder <- map_chr(pkg_with_change, ~here::here(common_root, .x, ".github", "workflows"))
copy_to_folders <- map_chr(pkg_without_change, ~here::here(common_root, .x, ".github", "workflows"))

file_name <- "R-CMD-check-strict.yaml"

purrr::walk2(
  .x = here::here(copy_from_folder, file_name),
  .y = here::here(copy_to_folders, file_name),
  .f = ~ fs::file_copy(.x, .y, overwrite = TRUE),
)
