# R Project Coding Conventions for easystats

This document outlines the common coding conventions observed in the `easystats` R projects.

## File Naming

*   Files are named with `snake_case` and should correspond to the main function they contain (e.g., `check_normality.R`).

## Package versioning

*   Package versions follow Semantic Versioning conventions.

*   If pull requests include user-visible changes, the "developer" version number should be increased (e.g. from 0.10.1.5 to 0.10.1.6). This ensures that `easystats::install_latest()` will download the latest versions.

## Code Style & Formatting

*   **Assignment:** Use the `<-` operator for assignment, not `=`.
*   **Spacing:**
    *   Use spaces around all infix operators (`<-`, `==`, `+`, etc.).
    *   Place a space after a comma, but not before.
*   **Curly Braces:**
    *   For function definitions, the opening `{` should be on its own line.
    *   For `if`/`else` statements, the opening `{` can be on the same line.
*   **Line Length:** Keep lines to a reasonable length (e.g., under 80-100 characters) to improve readability.

## Function Naming

*   **Public Functions:** Use lower case, underscore separated if more than one verb, i.e. `snake_case` (e.g., `check_normality()`, `model_performance()`). These functions should be exported.
*   **Internal Functions:** Prefix with a dot (`.`) and may use `snake_case` or `camelCase` (e.g., `.safe()`, `.get_BIC()`, `.check_normality()`). These functions should not be exported.
*   **Naming**: Common prefix for functions that focus on specific "tasks" or workflows (e.g. in package "insight", `get_*()` to get data, `find_*()` to find information, or in package "performance", `performance_*()` to compute measures of model quality, `check_*()` to check model assumptions...).

## Argument names

*   Lower case, underscore separated if more than one verb.
*   Arguments that refer to plot or table aesthetics (like size or alpha of geoms) should follow the pattern `aesthetics_geomtype`, e.g. `size_point`, `color_line` or `alpha_rope`.
*   "easystats" uses the argument name `by` to indicate grouping, not `group_by` or `at`.
*   Use `select` and `exclude` to select columns/variables, and `keep` or `drop` to select rows/observations.
*   Handling NA values, especially removing missing values, is done with `remove_na`.

## Element / Column names (for returned data frames)

*  First letter of the column name is capital, unless (6) applies (*example:* `Parameter`).

*  First letter of nouns is capital, unless (6) applies (*example:* `ROPE_Percentage`, `Prior_Scale`).

*  Using underscore rather than camelCase to separate words (*example:* `CI_high`).

*  Multiple words: common/main part first and adjective/specifier/variational part after, unless (8) applies (*example:* `Median_standardized`, `ROPE_percentage`).

*  Abbreviations: all uppercase (*example:* `ESS`, `MCSE`, `ROPE`).

*  Keep conventions for reserved words (*example:* `p`, `pd`, `Rhat`).

*   Adjectives / verbs: all lower case, unless (1) applies (*example:* `high` or `low` in `CI_high` or `CI_low`).

*   In case of multiple occurrences of column names that indicate the same measure or content (like `CI_low` or `SE`), the common part is appended as suffix to the context specific part (*example:* `CI_low` and `Eta2_partial_CI_low`, and **not** `CI_low` and `CI_low_Eta2_partial`).

*  The "squared" term in column names that refers to "common" statistics (`Eta2`, `Chi2`, `Omega2`, ...) should be written as `2`, not `sq`, `squared` or `pétit-deux` (*example:* `Chi2`, and **not** `Chisq`, `Eta2`, and **not** `Eta_squared`). This rule does **not** apply to function names.

*  Converting between "easystats" style and "broom" style can be done with `insight::standardize_names()`.

## Documentation (roxygen2)

All exported functions must be documented using `roxygen2`-style comments (`#'`). The documentation should include:

*   **Title:** A concise, one-line summary of what the function does.
*   **Description:** A more detailed paragraph explaining the function's purpose.
*   **`@param`:** A description for each function parameter.
*   **`@return`:** A description of the value the function returns.
*   **`@export`:** Tag to make the function available to users.
*   **`@examples` or `@examplesIf`:** Code demonstrating how to use the function.
*   **`@seealso`:** (Optional) Links to related functions.
*   **`@details`:** (Optional) Further details on the methodology or implementation.

## Dependencies

*   Use base-R wherever possible (to reduce hard dependencies)
*   Make sure R-version requirements are not too strict
*   **Package Functions:** Always use the `::` operator to call functions from other packages (e.g., `stats::shapiro.test`, `insight::model_info`). Do not use `library()` or `require()` at the top of a file (no full import, only selective import of functions).
*   **Conditional Checks:** Use `insight::check_if_installed("pkg_name")` to check if a package is available before using it, especially for optional ("Suggests") dependencies.

## S3 Object System

*   The projects make extensive use of the S3 object-oriented system.
*   **Generic Functions:** Define generic functions using `UseMethod("function_name")`.
*   **Methods:** Implement methods for specific object classes using the `function_name.class_name` naming convention (e.g., `check_normality.default`, `model_performance.lm`).

## Error Handling and Messaging

*   Use `tryCatch` for operations that might fail. The internal `.safe()` helper is a good example.
*   Use the `insight` package's functions for user-facing messages:
    *   `insight::format_error()`
    *   `insight::format_warning()`
    *   `insight::format_alert()`
    *   `insight::print_color()`
