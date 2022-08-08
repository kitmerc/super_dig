#!/usr/bin/env sh
if [ -n "$1" ]; then continue; else echo "can't find 1st arg"; exit; fi
DIG="dig +short"
GREEN="$(tput setaf 2)"
CLEAR="$(tput sgr0)"
IPCHK="yii ip/is-our-ip"
echo "main:" ${GREEN} "\n$($DIG A "$(hm "$1")")" ${CLEAR}
echo "\nwww:" ${GREEN}"\n$($DIG A "$(hm "$(echo "www."$1)")")" ${CLEAR}
echo "\nns:" ${GREEN}"\n$($DIG NS "$1")"  ${CLEAR}
echo "\nmx:" ${GREEN}"\n$($DIG MX "$1")" ${CLEAR}
echo "\ntxt:" ${GREEN}"\n$($DIG TXT "$1")"  ${CLEAR}
