#!/usr/bin/env bash
play "${1}" vol 0.15 trim "${2}" 5  &>/dev/null < /dev/null &
echo $! >> "${3}"
