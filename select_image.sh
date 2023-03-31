#!/bin/bash

EXTENSIONS=img,ext4,wic

if [[ $1 == "gz" ]];then
GZIP={,.gz}
fi

img_list=(`ls -1 $(eval echo "*.{$EXTENSIONS}$GZIP") 2>/dev/null`)
if [ -z "$img_list" ];then
echo "ERROR: No images found in current directory"
exit 1
fi

len=${#img_list[@]}

for ((i=0;i<$len;i++));do
    LIST=$LIST"[$((i+1))] ${img_list[$i]}"$'\n'
done
    
read -p "$LIST""select image [1-$((len))]:" index

re='^[1-9]+$'
if ! [[ $index =~ $re ]] ; then
    echo "ERROR: Wrong number"
    exit 1
fi

index=$index-1

if [ -z ${img_list[index]} ];then
    echo "ERROR: Wrong image"
    exit 1
fi

echo "${img_list[index]}"

exit 0