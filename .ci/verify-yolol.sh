#!/bin/bash
set -e

YODK=../yodk

function check_folder {

    cd $1

    ls *.yolol &>/dev/null || (echo "No .yolol files found"; exit 1)
    $YODK verify *.yolol || (echo "Yolol-files are invalid"; exit 1)

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