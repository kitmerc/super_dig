#!/bin/bash
if [ -z "$1" ]; then echo "can't find 1st arg"; exit; fi
arg1=$1
dig="dig +short"
green="$(tput setaf 5)"
cleare="$(tput sgr0)"

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
echo -e "main:"${green}"\n$($dig A "$(onlydomain)")"${cleare}
echo -e "\nwww:"${green}"\n$($dig A "www.""$(onlydomain)")"${cleare}
echo -e "\nns:"${green}"\n$($dig NS "$(onlydomain)")"${cleare}
echo -e "\nmx:"${green}"\n$($dig MX "$(onlydomain)")"${cleare}
echo -e "\ntxt:"${green}"\n$($dig TXT "$(onlydomain)")"${cleare}
