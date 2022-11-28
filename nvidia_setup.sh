#!/bin/bash
txt_red="\033[31m"
txt_green="\033[32m"
txt_reset="\033[0m"

if nc -zw1 google.com 443; then
    echo -e "$txt_green""\nInternet connection confirmed.""$txt_reset"
    set -eu -o pipefail
    sudo -n true
    test $? -eq 0 || exit 1 "You should have sudo privilege to run this installation script."

    echo -e "\033[42mInstalling Docker...\033[m"
    curl https://get.docker.com | sh
    echo -e "\033[42mDocker Installation Complete. Starting and Enabling now...\033[m"
    systemctl start docker && systemctl enable docker

    sudo bash -c "echo blacklist nouveau > /etc/modprobe.d/blacklist-nvidia-nouveau.conf"
    sudo bash -c "echo options nouveau modeset=0 >> /etc/modprobe.d/blacklist-nvidia-nouveau.conf"
    sudo update-initramfs -u

    wget https://us.download.nvidia.com/XFree86/Linux-x86_64/470.63.01/NVIDIA-Linux-x86_64-470.63.01.run

    chmod +x NVIDIA-Linux-x86_64-470.63.01.run
    ./NVIDIA-Linux-x86_64-470.63.01.run --no-x-check --no-cc-version-check
    nvidia-sci

    echo -e "\033[42mInstalling Nvidia Container toolkit...\033[m"

    distribution=$(. /etc/os-release; echo $ID$VERSION_ID)
    curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-get add -
    curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

    apt-get -y update
    apt-get install -y nvidia-docker2
    systemctl restart docker
    echo -e "\033[42mNVIDIA-Linux-x86_64-470 setup complete.\033[m"
else
  echo -e "$txt_red""\nInternet connection required prior to running this installation script.""$txt_reset"
fi



