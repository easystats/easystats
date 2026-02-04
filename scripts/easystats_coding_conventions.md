# R Project Coding Conventions for easystats

This document outlines the common coding conventions observed in the `easystats` R projects.

## File Naming

*   Files are named with `snake_case` and should correspond to the main function they contain (e.g., `check_normality.R`).

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

*   **Public Functions:** Use `snake_case` (e.g., `check_normality()`, `model_performance()`). These functions should be exported.
*   **Internal Functions:** Prefix with a dot (`.`) and may use `snake_case` or `camelCase` (e.g., `.safe()`, `.get_BIC()`, `.check_normality()`). These functions should not be exported.

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

*   **Package Functions:** Always use the `::` operator to call functions from other packages (e.g., `stats::shapiro.test`, `insight::model_info`). Do not use `library()` or `require()` at the top of a file.
*   **Conditional Checks:** Use `requireNamespace("pkg_name", quietly = TRUE)` to check if a package is available before using it, especially for optional ("Suggests") dependencies.

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
