#!/bin/bash

# Define the search and replace strings
search_string="# sanity check"
replace_string="# validation check"

# Find all .R files recursively in the current directory
# and replace the search string with the replace string
find . -type f -name "*.R" -exec sh -c '
  for file do
    sed "s/'"$search_string"'/'"$replace_string"'/I" "$file" > "$file.tmp" && mv "$file.tmp" "$file"
  done
' sh {} +
