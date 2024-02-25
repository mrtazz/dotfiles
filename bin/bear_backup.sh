#!/bin/sh


zipfile="${1}"
location="/Users/mrtazz/Backup/Bear/$(date '+%Y-%m-%d')"

mkdir -p "${location}/notes"
cp "${zipfile}" "${location}"

tar xvfz "${zipfile}" --cd "${location}/notes" --strip-components 1
