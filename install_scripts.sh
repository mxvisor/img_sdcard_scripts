#!/bin/sh
#for FILE in `ls --ignore='*.*'`;do
for FILE in `ls --ignore='install_scripts.sh'`;do
    ln -sf  $(dirname -- $(readlink -f -- $0; ))/$FILE  ~/bin/$FILE
done