#!/bin/sh
#for FILE in `ls --ignore='*.*'`;do
for FILE in `ls --ignore='install_scripts.sh' --ignore='README.md' `;do
    ln -sf  $(dirname -- $(readlink -f -- $0; ))/$FILE  ~/bin/$FILE
done