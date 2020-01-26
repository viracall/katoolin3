#!/bin/bash
set -euo pipefail

ARCH="amd64"
REPO="https://http.kali.org/"
DIST="kali-rolling"

INDEXFILE_URL="$REPO/dists/$DIST/main/binary-$ARCH/Packages.gz"

first_char(){
    echo $(echo "$1" | sed 's/^lib//' | head -c 1);
}

get_indexfile(){
    FILE="Packages"
    
    if [[ ! -f "$FILE" ]];
    then
        wget -q -O "$FILE.gz" "$INDEXFILE_URL";
        gunzip "$FILE";
    fi
}


cat Packages | sed 's/^$/\x00/' | grep -z -E "Package: 0ad"

