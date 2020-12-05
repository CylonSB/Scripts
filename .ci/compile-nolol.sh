#!/bin/bash
set -e

YODK=../yodk

function check_folder {

    cd $1

    if `ls *.nolol&>/dev/null`; then
        $YODK compile *.nolol || (echo "Compiling nolol-files failed"; exit 1)
    fi

    cd ..
}

for dir in Scripts/*/; do
    if `cat .testignore | grep -q "$dir"`; then
        echo "-----Skipping ignored folder: $dir -----"
        continue
    fi
    echo "-----Checking folder '$dir'-----"
    check_folder $dir
done