#!/bin/bash
set -e

YODK=../yodk

function check_folder {

    cd $1

    ls *test.yaml &>/dev/null || (echo "No test-files found"; exit 1)
    $YODK test *test.yaml || (echo "Tests failed"; exit 1)
    
    cd ..
}

for dir in Scripts/*; do
    if `cat .testignore | grep -q "$dir"`; then
        echo "-----Skipping ignored folder: $dir -----"
        continue
    fi
    echo "-----Checking folder '$dir'-----"
    check_folder $dir
done