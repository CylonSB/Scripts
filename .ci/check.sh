#!/bin/bash
set -e

YODK=../yodk

# check_folder <dir> <check> runs the given check for the given directory
function check_folder {

    pushd "${1}" > /dev/null

    if [ "$2" == "readme" ] || [ "$2" == "all" ]; then
        ls README.md &>/dev/null || (echo "ERROR: No README.md found"; exit 1)
    fi  

    if [ "$2" == "verify-yolol" ] || [ "$2" == "all" ]; then
        ls *.yolol &>/dev/null || (echo "ERROR: No .yolol files found"; exit 1)
        $YODK verify *.yolol || (echo "ERROR: Yolol-files are invalid"; exit 1)
    fi

    if [ "$2" == "compile-nolol" ] || [ "$2" == "all" ]; then
        if `ls *.nolol&>/dev/null`; then
            $YODK compile *.nolol || (echo "ERROR: Compiling nolol-files failed"; exit 1)
        fi
    fi

    if [ "$2" == "run-tests" ] || [ "$2" == "all" ]; then
        ls *test.yaml &>/dev/null || (echo "ERROR: No test-files found"; exit 1)
        $YODK test *test.yaml || (echo "ERROR: Tests failed"; exit 1)
    fi

    popd > /dev/null
}

for dir in Scripts/*/; do
    if `cat .testignore | grep -q "${dir}"`; then
        echo "-----Skipping ignored folder: ${dir} -----"
        continue
    fi
    echo "-----Checking folder '${dir}'-----"
    check_folder "${dir}" "$1"
done