load <- c(
  "insight", "bayestestR", "performance", "parameters", "see",
  "correlation", "estimate", "report"
)

.onAttach <- function(...) {
  easystats_versions <- .easystats_version()
  easystats_pkgs <- c("insight", "bayestestR", "performance", "parameters", "see", "correlation", "estimate", "report")
  needed <- easystats_pkgs[!is_attached(easystats_pkgs)]

  if (length(needed) == 0)
    return()

  easystats_versions <- easystats_versions[easystats_versions$package %in% needed, ]
  suppressPackageStartupMessages(suppressWarnings(lapply(easystats_versions$package, library, character.only = TRUE, warn.conflicts = FALSE)))

  needs_update <- easystats_versions$behind
  easystats_versions <- easystats_versions[, c("package", "local")]
  colnames(easystats_versions) <- c("Package", "Version")

  print.data.frame(easystats_versions, row.names = FALSE)
}

is_attached <- function(x) {
  paste0("package:", x) %in% search()
}
