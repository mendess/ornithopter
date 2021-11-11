#!/bin/sh

l="$(termux-location)"
lat="$(echo "$l" | jq .latitude)"
lon="$(echo "$l" | jq .longitude)"
printf "$l"
printf "($lat, $lon)" | termux-clipboard-set
