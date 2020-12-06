#!/bin/bash

set -e


urlencode() {
  local string="${1}"
  local strlen=${#string}
  local encoded=""
  local pos c o

  for (( pos=0 ; pos<strlen ; pos++ )); do
     c=${string:$pos:1}
     case "$c" in
        [-_.~a-zA-Z0-9] ) o="${c}" ;;
        * )               printf -v o '%%%02x' "'$c"
     esac
     encoded+="${o}"
  done
  echo "${encoded}"
}


rm -rf build || true

echo Copying files
mkdir -p build
cp -r website/* build
cp -r Scripts build
cp Readme.md build/README.md

pushd Scripts >/dev/null
echo Populating sidebar
for dir in */; do
    echo "  - [${dir%/}](/Scripts/${dir// /_})" >> ../build/_sidebar.md
done
popd >/dev/null

function add_sourcefiles {
    if `ls -al *.${1} &> /dev/null`; then
        for file in *.${1}; do
            echo " " >> README.md
            echo "### ${file}" >> README.md
            echo "[${file}](`urlencode \"${file}\"` ':include')" >> README.md
        done
    fi
}


pushd build/Scripts >/dev/null
echo Replacing spaces in foldernames
for f in *\ *; do mv "$f" "${f// /_}"; done

echo Processing scripts
for dir in */; do
    pushd "${dir}" >/dev/null
    echo " " >> README.md
    echo "## Files" >> README.md
    add_sourcefiles yolol
    add_sourcefiles nolol
    popd >/dev/null
done
popd >/dev/null