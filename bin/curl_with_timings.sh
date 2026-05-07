#!/bin/sh

curl -s -o /dev/null -w " \
   DNS Lookup:      %{time_namelookup}s\n \
   TCP Connect:     %{time_connect}s\n \
   App/TLS Connect: %{time_appconnect}s\n \
   Pre-transfer:    %{time_pretransfer}s\n \
   Start Transfer:  %{time_starttransfer}s\n \
   ----------\n \
   Total Time:      %{time_total}s\n" "${1}"
