.onAttach <- function(libname, pkgname) {
  # Global kill switches
  if (
    isTRUE(getOption("easystats.quiet")) ||
      identical(Sys.getenv("EASYSTATS_QUIET"), "1")
  ) {
    return(invisible())
  }

  cs <- sys.calls()
  for (i in seq_along(cs)) {
    fn <- try(sys.function(i), silent = TRUE)
    if (
      is.function(fn) &&
        (identical(fn, base::library) || identical(fn, base::require))
    ) {
      mc <- match.call(fn, cs[[i]])

      # quietly = TRUE → silence
      if (!is.null(mc$quietly) && isTRUE(eval(mc$quietly, parent.frame(i)))) {
        return(invisible())
      }

      # verbose = FALSE → silence
      if (!is.null(mc$verbose) && isFALSE(eval(mc$verbose, parent.frame(i)))) {
        return(invisible())
      }

      break
    }
  }

  easystats_versions <- .easystats_version()
  easystats_pkgs <- easystats_packages()
  needed <- easystats_pkgs[!.is_attached(easystats_pkgs)]

  if (length(needed) == 0L) {
    return()
  }

  easystats_versions <- easystats_versions[
    easystats_versions$package %in% needed,
  ]
  # We intentionally attach the easystats packages when the meta-package is attached,
  # mirroring the tidyverse pattern. This is an explicit UX choice for interactive use.
  # nolint start: package_hooks_linter
  suppressPackageStartupMessages(suppressWarnings(
    lapply(
      easystats_versions$package,
      library,
      character.only = TRUE,
      warn.conflicts = FALSE
    )
  ))
  # nolint end

  needs_update <- easystats_versions$behind
  easystats_versions <- easystats_versions[, c("package", "local")]

  max_len_pkg <- max(nchar(easystats_versions$package))
  max_len_ver <- max(nchar(easystats_versions$local))

  color_scheme <- insight::color_theme()

  if (!is.null(color_scheme) && color_scheme == "light") {
    theme_color <- "black"
  } else {
    theme_color <- "white"
  }

  final_message <- insight::color_text(
    paste0(
      "# Attaching packages: easystats ",
      utils::packageVersion("easystats")
    ),
    "blue"
  )

  if (any(needs_update)) {
    final_message <- paste0(final_message, insight::color_text(" (", "blue"))
    final_message <- paste0(final_message, insight::color_text("red", "red"))
    final_message <- paste0(
      final_message,
      insight::color_text(" = needs update)", "blue")
    )
  }

  final_message <- paste0(final_message, "\n")

  # adapted from {cli} package
  is_latex_output <- function() {
    if (!("knitr" %in% loadedNamespaces())) {
      return(FALSE)
    }
    get("is_latex_output", asNamespace("knitr"))()
  }

  is_utf8_output <- function() {
    opt <- getOption("cli.unicode", NULL)
    if (is.null(opt)) {
      l10n_info()$`UTF-8` && !is_latex_output()
    } else {
      isTRUE(opt)
    }
  }

  if (is_utf8_output()) {
    # symbol_warning <- "\u26A0 "
    symbol_tick <- "\u2714 "
    symbol_warning <- "\u2716 "
  } else {
    symbol_tick <- "\u221A "
    symbol_warning <- "x "
  }

  for (i in seq_len(nrow(easystats_versions))) {
    if (needs_update[i]) {
      final_message <- paste0(
        final_message,
        insight::color_text(symbol_warning, "red")
      )
    } else {
      final_message <- paste0(
        final_message,
        insight::color_text(symbol_tick, "green")
      )
    }

    final_message <- paste0(
      final_message,
      insight::color_text(
        format(easystats_versions$package[i], width = max_len_pkg),
        theme_color
      ),
      " ",
      insight::color_text(
        format(easystats_versions$local[i], width = max_len_ver),
        ifelse(needs_update[i], "red", "green")
      )
    )

    if (i %% 2 == 0L) {
      final_message <- paste0(final_message, "\n")
    } else {
      final_message <- paste0(final_message, "   ")
    }
  }

  if (any(needs_update)) {
    final_message <- paste0(
      final_message,
      insight::color_text(
        "\nRestart the R-Session and update packages with `easystats::easystats_update()`.\n",
        "yellow"
      )
    )
  }

  packageStartupMessage(final_message)
}

.is_attached <- function(x) {
  paste0("package:", x) %in% search()
}
