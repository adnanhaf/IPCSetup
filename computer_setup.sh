#!/bin/bash
txt_red="\033[31m"
txt_green="\033[32m"
txt_reset="\033[0m"

if nc -zw1 google.com 443; then
	echo -e "$txt_green""\nInternet connection confirmed.""$txt_reset"
	set -eu -o pipefail #fail on ERROR and REPORT it, DEBUG all lines.
	sudo -n true
	test $? -eq 0 || exit 1 "You should have sudo privilege to run this installation script."

	echo -e "\033[42mUpdating...\033[m"
	sudo apt update

	echo "\033[42mInstalling remote-access dependencies..."
	while read -r p ; do sudo apt-get install -y $p ; done < <(cat << "EOF"
		curl
		build-essential
		xrdp
		openssh-server
		git
		python3
		python3-pip
EOF
	)
	echo -e "\033[42menabling and starting ssh server\033[m"
	systemctl enable ssh && systemctl start ssh
	echo -e "\033[42mstarting xrdp...\033[m"
	systemctl enable xrdp
	cd ~
	echo -e "\033[42mInstalling Docker...\033[m"
	curl https://get.docker.com | sh
	echo -e "\033[42mDocker Installation Complete. Starting and Enabling now...\033[m"
	systemctl start docker && systemctl enable docker
	echo -e "\033[42mComputer setup complete\033[m"
else
  echo -e "$txt_red""\nInternet connection required prior to running this installation script.""$txt_reset"
fi

