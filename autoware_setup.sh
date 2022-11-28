#!/bin/bash
txt_red="\033[31m"
txt_green="\033[32m"
txt_reset="\033[0m"

if nc -zw1 google.com 443; then
    echo -e "$txt_green""\nInternet connection confirmed.""$txt_reset"
    set -eu -o pipefail
    sudo -n true
    test $? -eq 0 || exit 1 "You should have sudo privilege to run this installation script."

    mkdir -m 777 "adehome"
    cd "adehome"
    touch .adehome
    echo -e "\033[42mloning gitlab repo...\033[m"
    git clone https://gitlab.com/autowarefoundation/autoware.auto/AutowareAuto.git
    cd "AutowareAuto"
    git checkout tags/1.0.0 -b release-1.0.0
    echo -e "\033[42mFixing docker permissions...\033[m"
    usermod -aG docker $USER
    chmod 666 /var/run/docker.sock
    echo -e "\033[42mStarting Autoware...\033[m"
    ade start --update --enter
else
  echo -e "$txt_red""\nInternet connection required prior to running this installation script.""$txt_reset"
fi
