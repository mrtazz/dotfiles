#!/bin/bash
#
# small utility to view an email message containing markdown rendered in the
# Marked 2 app on macOS from mutt. You can use it from mutt with the following
# example macro '.m' from the index or pager:
#
# macro index,pager .m "<enter-command>set wait_key=no<enter><enter-command>set pipe_decode=yes<enter><pipe-entry>~/bin/mutt_to_marked.sh<enter>" 'Open entry in Marked app'
#
# Caveat: this will leave the last email viewed as a tempfile on your computer
# in $TMPDIR. This is up to you to decide whether it's a privacy issue or not.


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

