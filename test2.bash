#!/bin/bash
set -euo pipefail;

get_arch(){
    if [[ "$(getconf LONG_BIT)" -eq 64 ]];
    then
        echo "amd64";
    else
        echo "i386";
    fi
}

install_kali_repos(){
    echo "deb [arch=$(get_arch)] https://http.kali.org/kali kali-rolling main contrib non-free" | sudo tee /etc/apt/sources.list.d/katoolin3.list;
    sudo apt-get update;
}

uninstall_kali_repos(){
    sudo rm -f /etc/apt/sources.list.d/katoolin3.list;
    sudo apt-get update;
}

printf "Package> ";
read package;

install_kali_repos;
mkdir -p deb;
cd deb;
rm -f *.deb;
apt-get -d -m download $package;

for pkg in *.deb;
do
    sudo gdebi -n "$pkg" || true;
done

cd ..;
uninstall_kali_repos;
