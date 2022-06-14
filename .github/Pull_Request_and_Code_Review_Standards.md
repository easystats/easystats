# Pull Request and Code Review Standards

-   Please check if there is an existing issue that will be closed by the given PR. Unless it's a trivial change (spelling mistake, code formatting, etc.), this is likely the case.

-   Give the branch for the PR an informative name
    - If the PR will close an existing issue, name the branch with this format: `\<issue_number\>-short-description` (e.g. \`186_implement_data_extract\`).
    - If the PR doesn't close an existing issue, name the branch with this format: `\short-description` (e.g. \`improve-reshape-docs\`)

-   The title for the PR should provide a brief description about the changes.

-   The PR should be linked to the issue(s) that it targets, either by using [keywords](https://docs.github.com/en/issues/tracking-your-work-with-issues/linking-a-pull-request-to-an-issue) (like `fixes`, `closes`, etc.) in the PR description or by searching for the issue in the dropdown menu of the **Development** section of the right-side sidebar on the GitHub website.

-  If the PR doesn't close any issues, please either link to the comment or discussion that motivated it or provide a detailed description to explain the motivation for the PR.

-   If the PR is a work in progress, please mark it as a draft PR using the GitHub checkbox and add `[WIP]` to the PR title.

-   Reviewers will delay code review of draft PRs until they are marked ready for review (by removing `[WIP]` from the title and unchecking the "Draft" box), unless otherwise requested by the contributors.

-   Once the PR is marked as "Ready for Review", contributors should remember to remove `WIP` from the PR title.

-   Before marking the PR as "Ready for Review", contributors should also make sure that they are following the tidyverse style guide (enforced via `{styler}` package) and to make sure that automatic GitHub tests all finish successfully. If it is not possible for tests to finish successfully for some reason (e.g., because the PR relies on changes in *other repositories*), then the contributor should create new issue(s) for those required code changes, link them in the PR, and shortly explain why the change in the PR itself is not possible.

-   In general, fix one issue in a PR, and open new PRs to fix other issues. If a number of issues are related to the same underlying functionality, it is okay to address multiple issues in a single PR.

-   If it's a PR that adds significant new functionality, there might be multiple tasks to be completed. In such cases, try to prepare a checklist in the PR description and keep it updated so that the reviewers and contributors always have an up-to-date view of the status of the PR.

-   Any PR that makes a user-visible change should include a bump to package version number (`x.y.z.v` -> `x.y.z.v + 1`) and entry in the `NEWS.md` (with the name of the contributor if the contributor is not an author and issue number if available).

-   Reviewers should do their due diligence to understand the underlying issue, instead of asking contributors to reiterate the details that have already been outlined in GitHub Issues/Discussions.

-   If reviewers missed the issue that motivated the PR and would like to discuss it further when they see the PR, the discussion should take place in the original *issue* and not in the *PR* to minimize cognitive overhead of tracking the same discussion in two different places and to minimize the possibility of talking past each other.

-   The responsibility of resolving code review comments falls squarely on the reviewers. The contributors shouldn't themselves resolve the review comments, even if they are 100% confident that their latest commits address review comments.

-   Reviewers should not forget to review test code to make sure that it follows organization's coding standards.

-   Code review comments should strictly follow the ethical decorum stipulated by [Code of Conduct](https://github.com/Open-Systems-Pharmacology/Suite/blob/develop/CODE_OF_CONDUCT.md).

-   Reviewers should refrain from making remarks that can potentially be construed as hurtful or dismissive by contributors (e.g. "LMAO, what the hell is this?!"). The comments should be constructive, irrespective of whether they are terse or detailed.

-   Even if contributors possess the right to merge PRs to protected branches without code review, they should exercise this power responsibly and not to circumvent the "number of required reviews" condition stipulated for the protected branch.

## Further Reading

-   *The Missing Readme: A Guide for the New Software Engineer* by Chris Riccomini and Dmitriy Ryaboy (No Starch Press, 2021), Chapter 7.
