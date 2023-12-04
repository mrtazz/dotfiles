#!/bin/bash
#


tmpfile=$(mktemp)

echo "created tmpfile at ${tmpfile}..."

while read -r line
do
  echo "$line" >> "${tmpfile}"
done < "${1:-/dev/stdin}"


open -a "Marked 2" "${tmpfile}"

