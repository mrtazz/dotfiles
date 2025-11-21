#!/bin/sh

query=`cat`

echo "Running the following query:"
echo "${query}"
echo "with params:"
echo "$@"

gh api graphql -f query=''"${query}"'' "$@"
