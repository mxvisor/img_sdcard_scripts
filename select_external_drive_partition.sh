#!/bin/bash

dev_list=(`lsblk -A -n -o path,fstype,hotplug| awk -F' ' 'NF=3 && $3==1'`)

#|cut -d ' ' -f 1`)

len=${#dev_list[@]}

[[ $len != 0 ]] || { echo "ERROR: No external devices available"; exit 1; }

[[ $len == 1 ]] && { echo "${dev_list[0]}"; exit 0; }

for ((i=0;i<$len;i++)); do
    #echo [$i] ${dev_list[$i]} "("`lsblk -d -n -o size ${dev_list[$i]}`")"
    #printf "[$i] ${dev_list[$i]} (`lsblk -d -n -o size ${dev_list[$i]}`)\n"
    LIST=$LIST"[$((i+1))] ${dev_list[$i]} (`lsblk -d -n -o size,uuid,label ${dev_list[$i]}`)"$'\n'
done

read -p "$LIST""select partition [1-$((len))]:" index

re='^[1-9]+$'
[[ $index =~ $re ]] || { echo "ERROR: Entered value is not number"; exit 1; }

index=$index-1

[[ ! -z ${dev_list[index]} ]] || { echo "ERROR: Entered number out of range";exit 1; }

echo ${dev_list[index]}
exit 0
