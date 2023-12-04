#!/bin/bash
#


TMPFILE_PREFIX="mutt_to_marked"

# first clean up any leftover files

rm -f "${TMPDIR}/${TMPFILE_PREFIX}"*

tmpfile=$(mktemp -t "${TMPFILE_PREFIX}")

echo "created tmpfile at ${tmpfile}..."

while read -r line
do
  echo "$line" >> "${tmpfile}"
done < "${1:-/dev/stdin}"


open -a "Marked 2" "${tmpfile}"

