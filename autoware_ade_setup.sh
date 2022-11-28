#!/bin/bash
txt_red="\033[31m"
txt_green="\033[32m"
txt_reset="\033[0m"

if nc -zw1 google.com 443; then
    echo -e "$txt_green""\nInternet connection confirmed. Proceeding with installation.""$txt_reset"
    set -eu -o pipefail
    sudo -n true
    test $? -eq 0 || exit 1 "You should have sudo privilege to run this installation script."
    echo -e "\033[42mADE Setup...\033[m"
    echo -e "\033[42mmoving to installation directory...\033[m"
    cd /usr/local/bin
    wget https://gitlab.com/ApexAI/ade-cli/-/jobs/1859684348/artifacts/raw/dist/ade+x86_64
    mv ade+x86_64 ade
    chmod +x ade
    ./ade --version
    echo -e "\033[42mADE setup complete...\033[m"
else
  echo -e "$txt_red""\nInternet connection required prior to running this installation script.""$txt_reset"
fi
