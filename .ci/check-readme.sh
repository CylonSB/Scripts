#!/bin/bash
set -e

function check_folder {

    cd $1

    ls README.md &>/dev/null || (echo "No README.md found"; exit 1)

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