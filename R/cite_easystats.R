#' Cite the easystats ecosystem
#'
#' A convenient function for those who wish to cite the easystats packages.
#'
#' @param packages A character vector of packages to cite. Can be `"all"` for
#'   all *easystats* packages or a vector with specific package names.
#' @param format The format to generate citations. Can be `"text"` for plain
#'   text, `"markdown"` for markdown citations and CSL bibliography
#'   (recommended for writing in RMarkdown), or `"biblatex"` for BibLaTeX
#'   citations and bibliography.
#' @param intext_prefix A character vector of length 1 containing text to
#'   include before in-text citations. If `TRUE`, defaults to `"Analyses were
#'   conducted using the easystats collection of packages "`. If `FALSE` or
#'   `NA`, no prefix is included.
#' @param intext_suffix A character vector of length 1 containing text to
#'   include after in-text citations. Defaults to `"."`. If `FALSE` or `NA`,
#'   no suffix is included.
#' @param x,object A `"cite_easystats"` object to print.
#' @param what What elements of the citations to print, can be `"all"`,
#'   `"intext"`, or `"refs"`.
#' @param ... Not used. Included for compatibility with the generic function.
#'
#' @return A list of class `"cite_easystats"` with elements:
#'   - `intext`: In-text citations in the requested `format`
#'   - `refs`: References or bibliography in the requested `format`
#'
#' @examples
#' \donttest{
#' # Cite just the 'easystats' umbrella package:
#' cite_easystats()
#' summary(cite_easystats(), what = "all")
#'
#' # Cite every easystats package:
#' cite_easystats(packages = "all")
#' summary(cite_easystats(packages = "all"), what = "all")
#'
#' # Cite specific packages:
#' cite_easystats(packages = c("modelbased", "see"))
#' summary(cite_easystats(packages = c("modelbased", "see")), what = "all")
#'
#' # To cite easystats packages in an RMarkdown document, use:
#'
#' ## In-text citations:
#' print(cite_easystats(format = "markdown"), what = "intext")
#'
#' ## Bibliography (print with the  `output = 'asis'` option on the code chunk)
#' print(cite_easystats(format = "markdown"), what = "refs")
#' }
#'
#' @export
cite_easystats <- function(
  packages = "easystats",
  format = c("text", "markdown", "biblatex"),
  intext_prefix = TRUE,
  intext_suffix = "."
) {
  format <- match.arg(format, choices = c("text", "markdown", "biblatex"))
  installed_packages <- utils::installed.packages()[, "Version"]

  # Determine list of packages to cite
  if (length(packages) == 1 && packages == "all") {
    packages <- c(
      "easystats",
      "insight",
      "datawizard",
      "bayestestR",
      "performance",
      "parameters",
      "effectsize",
      "correlation",
      "modelbased",
      "see",
      "report"
    )
  }

  # Handle missing packages (with special exception for easystats meta-package)
  missing_packages <- setdiff(packages, names(installed_packages))
  if (length(missing_packages)) {
    # Special case: easystats meta-package is always available for citation
    if ("easystats" %in% missing_packages) {
      missing_packages <- setdiff(missing_packages, "easystats")
      if (!"easystats" %in% names(installed_packages)) {
        installed_packages <- c(installed_packages, easystats = "")
      }
    }
    # Report and remove other missing packages
    if (length(missing_packages)) {
      message(insight::format_message(
        "Requested package(s) not installed:",
        toString(missing_packages),
        "Citations to these packages omitted."
      ))
      packages <- setdiff(packages, missing_packages)
    }
  }

  # in-text
  if (format == "text") {
    letters_ludecke_packages <- .disamguation_letters(
      c(
        "easystats",
        "insight",
        "performance",
        "parameters",
        "see"
      ) %in%
        packages
    )
    if (sum(nzchar(letters_ludecke_packages)) == 1) {
      letters_ludecke_packages <- rep("", length(letters_ludecke_packages))
    }
    letters_ludecke_articles <- .disamguation_letters(
      c("performance", "see") %in% packages
    )
    if (sum(nzchar(letters_ludecke_articles)) == 1) {
      letters_ludecke_articles <- rep("", length(letters_ludecke_articles))
    }
    letters_makowski_packages <- .disamguation_letters(
      c(
        "datawizard",
        "bayestestR",
        "correlation",
        "modelbased",
        "report"
      ) %in%
        packages
    )
    if (sum(nzchar(letters_makowski_packages)) == 1) {
      letters_makowski_packages <- rep("", length(letters_makowski_packages))
    }
    easystats <- "easystats"
    cit_packages <- sprintf(
      "(%s)",
      toString(c(
        easystats = sprintf(
          "L\u00fcdecke et al., 2019/2023%s",
          letters_ludecke_packages[1]
        ),
        insight = sprintf(
          "L\u00fcdecke et al., 2019, 2019/2022%s",
          letters_ludecke_packages[2]
        ),
        datawizard = sprintf(
          "Makowski et al., 2021/2022%s",
          letters_makowski_packages[1]
        ),
        bayestestR = sprintf(
          "Makowski et al., 2019, 2019/2022%s",
          letters_makowski_packages[2]
        ),
        performance = sprintf(
          "L\u00fcdecke et al., 2021%s, 2019/2022%s",
          letters_ludecke_articles[1],
          letters_ludecke_packages[3]
        ),
        parameters = sprintf(
          "L\u00fcdecke et al., 2020, 2019/2022%s",
          letters_ludecke_packages[4]
        ),
        effectsize = "Ben-Shachar et al., 2020, 2019/2022",
        correlation = sprintf(
          "Makowski et al., 2020, 2020/2022%s",
          letters_makowski_packages[3]
        ),
        modelbased = sprintf(
          "Makowski et al., 2020/2022%s",
          letters_makowski_packages[4]
        ),
        see = sprintf(
          "L\u00fcdecke et al., 2021%s, 2019/2022%s",
          letters_ludecke_articles[2],
          letters_ludecke_packages[5]
        ),
        report = sprintf(
          "Makowski et al., 2021/2023%s",
          letters_makowski_packages[5]
        )
      )[packages])
    )
  } else if (format == "markdown") {
    easystats <- "_easystats_"
    cit_packages <- sprintf(
      "[%s]",
      toString(c(
        easystats = "@easystatsPackage",
        insight = "@insightArticle, @insightPackage",
        datawizard = "@datawizardPackage",
        bayestestR = "@bayestestRArticle, @bayestestRPackage",
        performance = "@performanceArticle, @performancePackage",
        parameters = "@parametersArticle, @parametersPackage",
        effectsize = "@effectsizeArticle, @effectsizePackage",
        correlation = "@correlationArticle, @correlationPackage",
        modelbased = "@modelbasedPackage",
        see = "@seeArticle, @seePackage",
        report = "@reportPackage"
      )[packages])
    )
  } else {
    easystats <- "\\emph{easystats}"
    cit_packages <- sprintf(
      "\\cite{%s}",
      toString(c(
        easystats = "easystatsPackage",
        insight = "insightArticle, insightPackage",
        datawizard = "datawizardPackage",
        bayestestR = "bayestestRArticle, bayestestRPackage",
        performance = "performanceArticle, performancePackage",
        parameters = "parametersArticle, parametersPackage",
        effectsize = "effectsizeArticle, effectsizePackage",
        correlation = "correlationArticle, correlationPackage",
        modelbased = "modelbasedPackage",
        see = "seeArticle, seePackage",
        report = "reportPackage"
      )[packages])
    )
  }

  if (isTRUE(intext_prefix)) {
    intext_prefix <- sprintf(
      "Analyses were conducted using the %s collection of packages ",
      easystats
    )
  } else if (isFALSE(intext_prefix)) {
    intext_prefix <- ""
  }
  if (isTRUE(intext_suffix)) {
    intext_suffix <- "."
  }
  if (isFALSE(intext_suffix) || is.na(intext_suffix)) {
    intext_suffix <- ""
  }
  intext <- sprintf("%s%s%s", intext_prefix, cit_packages, intext_suffix)

  # references
  if (format == "text") {
    ref_packages <- paste0(
      "- ",
      sort(unlist(list(
        easystats = sprintf(
          paste(
            "L\u00fcdecke, D., Makowski, D., Ben-Shachar, M. S., Patil, I.,",
            "Wiernik, B. M., Bacher, Etienne, & Th\u00e9riault, R. (2023).",
            "easystats: Streamline model interpretation, visualization,",
            "and reporting%s [R package].",
            "https://easystats.github.io/easystats/",
            "(Original work published 2019)"
          ),
          ifelse(
            nzchar(installed_packages["easystats"]),
            paste0(" (", installed_packages["easystats"], ")"),
            ""
          )
        ),
        insight = c(
          article = paste(
            "L\u00fcdecke, D., Waggoner, P., & Makowski, D. (2019).",
            "insight: A unified interface to access information from",
            "model objects in R.",
            "Journal of Open Source Software, 4(38), 1412.",
            "https://doi.org/10.21105/joss.01412"
          ),
          package = sprintf(
            paste(
              "L\u00fcdecke, D., Makowski, D., Patil, I., Waggoner,",
              "P., Ben-Shachar, M. S., Wiernik, B. M., & Arel-Bundock, V. (2022).",
              "insight: Easy access to model information for various model objects (%s) [R package].",
              "https://CRAN.R-project.org/package=insight (Original work published 2019)"
            ),
            installed_packages["insight"]
          )
        ),
        datawizard = sprintf(
          paste(
            "Makowski, D., L\u00fcdecke, D., Patil, I., Ben-Shachar, M. S., & Wiernik, B. M. (2022).",
            "datawizard: Easy data wrangling (%s) [R package].",
            "https://CRAN.R-project.org/package=datawizard (Original work published 2021)"
          ),
          installed_packages["datawizard"]
        ),
        bayestestR = c(
          article = paste(
            "Makowski, D., Ben-Shachar, M., & L\u00fcdecke, D. (2019).",
            "bayestestR: Describing effects and their uncertainty, existence",
            "and significance within the Bayesian framework.",
            "Journal of Open Source Software, 4(40), 1541. https://doi.org/10.21105/joss.01541"
          ),
          package = sprintf(
            paste(
              "Makowski, D., L\u00fcdecke, D., Ben-Shachar, M. S., Patil, I.,",
              "Wilson, M. D., & Wiernik, B. M. (2021).",
              "bayestestR: Understand and describe Bayesian models and posterior distributions (%s) [R package].",
              "https://CRAN.R-project.org/package=bayestestR (Original work published 2019)"
            ),
            installed_packages["bayestestR"]
          )
        ),
        performance = c(
          article = paste(
            "L\u00fcdecke, D., Ben-Shachar, M., Patil, I., Waggoner, P., & Makowski, D. (2021).",
            "performance: An R package for assessment, comparison and testing of statistical models.",
            "Journal of Open Source Software, 6(60), 3139. https://doi.org/10.21105/joss.03139"
          ),
          package = sprintf(
            paste(
              "L\u00fcdecke, D., Makowski, D., Ben-Shachar, M. S., Patil,",
              "I., Waggoner, P., & Wiernik, B. M. (2021).",
              "performance: Assessment of regression models performance (%s) [R package].",
              "https://CRAN.R-project.org/package=performance (Original work published 2019)"
            ),
            installed_packages["performance"]
          )
        ),
        parameters = c(
          article = paste(
            "L\u00fcdecke, D., Ben-Shachar, M., Patil, I., & Makowski, D. (2020).",
            "Extracting, computing and exploring the parameters of statistical models using R.",
            "Journal of Open Source Software, 5(53), 2445. https://doi.org/10.21105/joss.02445"
          ),
          package = sprintf(
            paste(
              "L\u00fcdecke, D., Makowski, D., Ben-Shachar, M. S., Patil, I.,",
              "H\u00F8jsgaard, S., & Wiernik, B. M. (2022).",
              "parameters: Processing of model parameters (%s) [R package].",
              "https://CRAN.R-project.org/package=parameters (Original work published 2019)"
            ),
            installed_packages["parameters"]
          )
        ),
        effectsize = c(
          article = paste(
            "Ben-Shachar, M. S., L\u00fcdecke, D., & Makowski, D. (2020).",
            "effectsize: Estimation of effect size indices and standardized parameters.",
            "Journal of Open Source Software, 5(56), 2815. https://doi.org/10.21105/joss.02815"
          ),
          package = sprintf(
            paste(
              "Ben-Shachar, M. S., Makowski, D., L\u00fcdecke, D., Patil, I., & Wiernik, B. M. (2022).",
              "effectsize: Indices of effect size and standardized parameters (%s) [R package].",
              "https://CRAN.R-project.org/package=effectsize (Original work published 2019)"
            ),
            installed_packages["effectsize"]
          )
        ),
        correlation = c(
          article = paste(
            "Makowski, D., Ben-Shachar, M., Patil, I., & L\u00fcdecke, D. (2020).",
            "Methods and algorithms for correlation analysis in R.",
            "Journal of Open Source Software, 5(51), 2306. https://doi.org/10.21105/joss.02306"
          ),
          package = sprintf(
            paste(
              "Makowski, D., Wiernik, B. M., Patil, I., L\u00fcdecke, D., & Ben-Shachar, M. S. (2022).",
              "correlation: Methods for correlation analysis (%s) [R package].",
              "https://CRAN.R-project.org/package=correlation (Original work published 2020)"
            ),
            installed_packages["correlation"]
          )
        ),
        modelbased = sprintf(
          paste(
            "Makowski, D., L\u00fcdecke, D., Ben-Shachar, M. S., & Patil, I. (2022).",
            "modelbased: Estimation of model-based predictions, contrasts and means (%s) [R package].",
            "https://CRAN.R-project.org/package=modelbased (Original work published 2020)"
          ),
          installed_packages["modelbased"]
        ),
        see = c(
          article = paste(
            "L\u00fcdecke, D., Patil, I., Ben-Shachar, M. S., Wiernik,",
            "B. M., Waggoner, P., & Makowski, D. (2021).",
            "see: An R package for visualizing statistical models.",
            "Journal of Open Source Software, 6(64), 3393. https://doi.org/10.21105/joss.03393"
          ),
          package = sprintf(
            paste(
              "L\u00fcdecke, D., Makowski, D., Patil, I., Ben-Shachar, M. S., Wiernik,",
              "B. M., & Waggoner, P. (2022).",
              "see: Visualisation toolbox for 'easystats' (%s) [R package].",
              "https://CRAN.R-project.org/package=see (Original work published 2019)"
            ),
            installed_packages["see"]
          )
        ),
        report = sprintf(
          paste(
            "Makowski, D., L\u00fcdecke, D., Patil, I., Th\U00E9riault, R., Ben-Shachar, M. S.,",
            "& Wiernik, B. M. (2023).",
            "report: Automated reporting of results and statistical models (%s) [R package].",
            "https://easystats.github.io/easystats/ (Original work published 2021)"
          ),
          installed_packages["report"]
        )
      )[packages])),
      "\n"
    )
  } else if (format == "markdown") {
    ref_packages <- readLines(system.file(
      "easystats_bib.yaml",
      package = "easystats"
    ))
    ref_packages[ref_packages == "  version: %s"] <- sprintf(
      ref_packages[ref_packages == "  version: %s"],
      c(
        installed_packages["bayestestR"],
        installed_packages["correlation"],
        installed_packages["datawizard"],
        installed_packages["easystats"],
        installed_packages["effectsize"],
        installed_packages["insight"],
        installed_packages["modelbased"],
        installed_packages["parameters"],
        installed_packages["performance"],
        installed_packages["report"],
        installed_packages["see"]
      )
    )
    ref_packages <- list(
      ref_packages[1:2],
      ref_packages[-c(1:2, length(ref_packages))],
      ref_packages[length(ref_packages)]
    )
    ref_packages[[2]] <- split(
      ref_packages[[2]],
      cumsum(!nzchar(ref_packages[[2]]))
    )
    ref_packages_index <- grep(
      paste0("id: ((", paste(packages, collapse = ")|("), "))"),
      ref_packages[[2]]
    )
    ref_packages[[2]] <- unlist(
      ref_packages[[2]][ref_packages_index],
      use.names = FALSE
    )
    ref_packages <- paste(
      unlist(ref_packages, use.names = FALSE),
      collapse = "\n"
    )
  } else {
    ref_packages <- readLines(system.file(
      "easystats_bib.bib",
      package = "easystats"
    ))
    ref_packages[ref_packages == "  version = {%s}"] <- sprintf(
      ref_packages[ref_packages == "  version = {%s}"],
      c(
        installed_packages["bayestestR"],
        installed_packages["correlation"],
        installed_packages["datawizard"],
        installed_packages["easystats"],
        installed_packages["effectsize"],
        installed_packages["insight"],
        installed_packages["modelbased"],
        installed_packages["parameters"],
        installed_packages["performance"],
        installed_packages["report"],
        installed_packages["see"]
      )
    )
    ref_packages <- split(ref_packages, cumsum(!nzchar(ref_packages)))
    # Match BibTeX entries where citation key starts with package name
    # Keys are like "insightArticle", "insightPackage", etc.
    ref_packages_index <- grep(
      paste0(
        "@(article|software)\\{(",
        paste(packages, collapse = "|"),
        ")(Article|Package)"
      ),
      ref_packages
    )
    ref_packages <- unlist(ref_packages[ref_packages_index], use.names = FALSE)
    ref_packages <- paste(
      unlist(ref_packages, use.names = FALSE),
      collapse = "\n"
    )
  }

  out <- list(
    intext = intext,
    refs = ref_packages
  )

  class(out) <- c("cite_easystats", class(out))
  out
}


#' @export
#' @rdname cite_easystats
summary.cite_easystats <- function(object, what = "all", ...) {
  what <- match.arg(what, choices = c("all", "cite", "intext", "bib", "refs"))
  what <- switch(what,
    all = "all",
    cite = ,
    intext = "intext",
    bib = ,
    refs = "refs"
  )
  switch(what,
    all = {
      insight::print_colour("\nCitations\n----------\n\n", "blue")
      cat(
        strwrap(object$intext, exdent = 0, width = 0.95 * getOption("width")),
        sep = "\n"
      )
      cat("\n")
      insight::print_colour("\nReferences\n----------\n\n", "blue")
      cat(
        unlist(lapply(
          object$refs,
          strwrap,
          exdent = 4,
          width = 0.95 * getOption("width")
        )),
        sep = "\n"
      )
      cat("\n")
    },
    intext = {
      cat(
        strwrap(object$intext, exdent = 0, width = 0.95 * getOption("width")),
        sep = "\n"
      )
    },
    refs = {
      cat(
        unlist(lapply(
          object$refs,
          strwrap,
          exdent = 4,
          width = 0.95 * getOption("width")
        )),
        sep = "\n"
      )
    }
  )
}


#' @export
#' @rdname cite_easystats
print.cite_easystats <- function(x, what = "all", ...) {
  what <- match.arg(what, choices = c("all", "cite", "intext", "bib", "refs"))
  what <- switch(what,
    all = "all",
    cite = ,
    intext = "intext",
    bib = ,
    refs = "refs"
  )
  if (what == "all") {
    insight::print_colour(
      sprintf(
        "Thanks for crediting us! %s You can cite the easystats ecosystem as follows:",
        ifelse(.support_unicode(), "\U1F600", ":)")
      ),
      "blue"
    )
    cat("\n")
  }
  summary(x, what = what, ...)
}


.disamguation_letters <- function(x) {
  if (!is.logical(x)) {
    stop("`x` must be a logical vector.", call. = FALSE)
  }
  count <- sum(x)
  x[!x] <- ""
  if (count > 26) {
    warning(
      "More than 26 packages require disambiguation letters. ",
      "Only first 26 will be labeled.",
      call. = FALSE
    )
    count <- 26
  }
  x[nzchar(x)] <- letters[seq_len(count)]
  x
}
