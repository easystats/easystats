# Contribution Guidelines

^(easystats guidelines 0.1.0)

**All people are very much welcome to contribute to code, documentation,
testing and suggestions.**

This package aims at being beginner-friendly. Even if you’re new to this
open-source way of life, new to coding and github stuff, we encourage
you to try submitting pull requests (PRs).

- **“I’d like to help, but I’m not good enough with programming yet”**

It’s alright, don’t worry! You can always dig in the code, in the
documentation or tests. There are always some typos to fix, some docs to
improve, some details to add, some code lines to document, some tests to
add… **Even the smaller PRs are appreciated**.

- **“I’d like to help, but I don’t know where to start”**

You can look around the **issue section** to find some features / ideas
/ bugs to start working on. You can also open a new issue **just to say
that you’re there, interested in helping out**. We might have some ideas
adapted to your skills.

- **“I’m not sure if my suggestion or idea is worthwile”**

Enough with the impostor syndrome! All suggestions and opinions are
good, and even if it’s just a thought or so, it’s always good to receive
feedback.

- **“Why should I waste my time with this? Do I get any credit?”**

Software contributions are getting more and more valued in the academic
world, so it is a good time to collaborate with us! Authors of
substantial contributions will be added within the **authors** list.
We’re also very keen on including them to eventual academic
publications.

**Anyway, starting is the most important! You will then enter a *whole
new world, a new fantastic point of view*… So fork this repo, do some
changes and submit them. We will then work together to make the best out
of it :)**

## Code

- Please document and comment your code, so that the purpose of each
  step (or code line) is stated in a clear and understandable way.
- Before submitting a change, please read the [**R style
  guide**](https://style.tidyverse.org/) and in particular our
  [**easystats convention of
  code-style**](https://github.com/easystats/easystats#convention-of-code-style)
  to keep some consistency in code formatting.
- Regarding the style guide, note this exception: we put readability and
  clarity before everything. Thus, we like underscores and full names
  (prefer `model_performance` over `modelperf` and
  `interpret_odds_logistic` over `intoddslog`).
- Before you start to code, make sure you’re on the `dev` branch (the
  most “advanced”). Then, you can create a new branch named by your
  feature (e.g., `feature_lightsaber`) and do your changes. Finally,
  submit your branch to be merged into the `dev` branch. Then, every now
  and then, the dev branch will merge into `master`, as a new package
  version.

## Checks to do before submission

- Make sure **documentation** (roxygen) is good

- Make sure to add **tests** for the new functions

- Run:

  - `styler::style_pkg()`: Automatic style formatting
  - [`lintr::lint_package()`](https://lintr.r-lib.org/reference/lint.html):
    Style checks
  - `devtools::check()`: General checks

See our [Pull Request and Code Review
Standards](https://easystats.github.io/easystats/Pull_Request_and_Code_Review_Standards.html)

## Useful Materials

- [Understanding the GitHub
  flow](https://guides.github.com/introduction/flow/)
