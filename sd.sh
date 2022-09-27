#!/bin/bash
if [ -z "$1" ]; then echo "can't find 1st arg"; exit; fi
if [ -n "$2" ]; then dig="dig +short "$2""; else dig="dig +short"; fi
arg1=$1
yellow="$(tput setaf 3)"
green="$(tput setaf 2)"
cleare="$(tput sgr0)"
ipcheck="yii ip/is-our-ip"
onlydomain () {
checkhttp=$(echo $arg1 | tr A-Z a-z | grep -o "http://")
checkhttps=$(echo $arg1 | tr A-Z a-z | grep -o "https://")
if [[ "$checkhttp" = "http://" ]];then
                total=$(echo $arg1 | tr A-Z a-z | cut -c 8-)
elif [[ "$checkhttps" = "https://" ]];then
        total=$(echo $arg1 | tr A-Z a-z | cut -c 9-)
else
        total=$(echo $arg1 | tr A-Z a-z)
fi
check=$(expr index "$total" "/")
if [[ $check == 0 ]];then
        echo $total
else
        let "last=$check - 1"
        echo "$total" | cut -c -"$last"
fi
}
echo -e ${yellow}"main:"${cleare}${green}"\n$($dig A "$(onlydomain)")"${cleare}
echo -e ${yellow}"www:"${cleare}${green}"\n$($dig A "www.""$(onlydomain)")"${cleare}
echo -e ${yellow}"ns:"${cleare}${green}"\n$($dig NS "$(onlydomain)")"${cleare}
echo -e ${yellow}"mx:"${cleare}${green}"\n$($dig MX "$(onlydomain)")"${cleare}
echo -e ${yellow}"txt:"${cleare}${green}"\n$($dig TXT "$(onlydomain)")"${cleare}
