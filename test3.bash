#!/bin/bash

export LC_ALL=C

# kali repositories need to be enabled for this
apt-rdepends -p --state-show=NotInstalled "$1" | grep 'Depends:' | cut -d " " -f 4 | sort | uniq;

is_from_kali(){
    pkg="$1";
    sources=$(apt show -a "$pkg" | grep 'Package:' | cut -d " " -f 2)
    
    if [[ $(echo "$sources" | tr " " "\n" | wc -l) -eq 1 ]];
    then
        echo "$pkg";
    fi
}
