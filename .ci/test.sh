#!/bin/bash
set -e

YODK=../yodk

function check_folder {

    cd $1

    ls README.md &>/dev/null || (echo "No README.md found"; exit 1)

    ls *.yolol &>/dev/null || (echo "No .yolol files found"; exit 1)

    $YODK verify *.yolol || (echo "Yolol-files are invalid"; exit 1)

    ls *test.yaml &>/dev/null || (echo "No test-files found"; exit 1)

    $YODK test *test.yaml || (echo "Tests failed"; exit 1)

    if `ls *.nolol&>/dev/null`; then
        $YODK compile *.nolol || (echo "Compiling nolol-files failed"; exit 1)
    fi

    cd ..
}

for dir in */; do
    if `cat .testignore | grep -q "$dir"`; then
        echo "-----Skipping ignored folder: $dir -----"
        continue
    fi
    echo "-----Checking folder '$dir'-----"
    check_folder $dir
done