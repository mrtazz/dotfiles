#!/bin/bash
# quick script to convert a datev payslip to a JD (https://johnnydecimal.com/) named file

JD_PREFIX="13.06"
current_file=${1}
suffix="-datev.pdf"

new_filename=$(echo ${current_file} | awk '{print $2"-"$3}')

version=$(echo ${current_file} | grep -o '([0-9])' | sed 's/(//g' | sed 's/)//g')

if [[ -n "${version}" ]] ; then
  version="-${version}"
fi

new_filename="${JD_PREFIX}-${new_filename}${version}${suffix}"

cp "${current_file}" ${new_filename}
