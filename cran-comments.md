Dear CRAN-team,
we hopefully addressed all issues you raised to your satisfaction. Let us briefly summarize what we changed after your request:

- Please do not start the description with "This package", package name, title or similar.

Response:

We have revised the package description accordingly.

- If there are references describing the methods in your package, please add these in the description field of your DESCRIPTION

Response:

Not applicable, we had no references in the DESCRIPTION field.

- Functions which are supposed to only run interactively (e.g. shiny)
should be wrapped in if(interactive()). This does not seem necessary for
your functions Please replace if(interactive()){} if possible.

Response:

We have checked the examples. One example requires internet access, another examples writes a temporary HTML file and opens a webbrowser to display that file. According to the document "Writing R Extensions", we refer to section 2.1.1 (Documenting functions), under "examples":

> In addition, it should not use any system-specific features or require special facilities (such as Internet access or write permission to specific directories).

Thus, we think that for these examples the "interactive()" function appropriate. Please let us know if we misunderstood the manual here.
