#!/bin/sh

### FUNCTIONS ###
error() {
	printf "%s\n" "$1" >&2
	exit 1
}

installGoogleChrome() {
	printf "Installing Google Chrome \n"
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo apt install ./google-chrome-stable_current_amd64.deb -y
	rm -rf ./google-chrome-stable_current_amd64.deb
}

installVSCode() {
	printf "Installing VSCode \n"
	sudo apt-get install wget gpg
	wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
	sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
	sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
	rm -f packages.microsoft.gpg

	sudo apt install apt-transport-https
	sudo apt update
	sudo apt install code
}

installLatex() {
	printf "Installing Latex \n"
	sudo apt install texlive/stable -y
	sudo apt install latexmk/stable -y
}

installIBus() {
	sudo apt-get install ibus-unikey -y
	# ibus-setup
	# ibus-daemon
}

installZsh() {
	sudo apt install zsh - y
	touch ~/.zshenv
	mkdir -p ~/config/zsh
	echo "ZDOTDIR=$HOME/config/zsh" >~/.zshenv
	chsh -s $(which zsh)
}

installGit() {
	sudo apt install git -y
}

installCurl() {
	sudo apt install curl -y
}

installBuildTools() {
	sudo apt install build-essential libx11-dev libxft-dev xhk libxinerama-dev -y
}

installFnm() {
	curl -fsSL https://fnm.vercel.app/install | bash
	sudo mv ~/.fnm/fnm /bin/
	rm -rf ~/.fnm ~/.zshrc
}

installWget() {
	sudo apt install wget
}

installFlameshot() {
	sudo apt install flameshot/stable
}

installDocker() {
	sudo apt-get remove docker docker-engine docker.io containerd runc
	sudo apt-get update
	sudo apt-get install ca-certificates curl gnupg lsb-release
	curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
	echo \
		"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
	sudo apt-get update
	sudo apt-get install docker-ce docker-ce-cli containerd.io

	sudo usermod -aG docker $USER
	newgrp docker
	sudo systemctl enable docker.service
	sudo systemctl enable containerd.service
}

installDockerCompose() {
	sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
	sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
	sudo curl \
		-L https://raw.githubusercontent.com/docker/compose/1.29.2/contrib/completion/bash/docker-compose \
		-o /etc/bash_completion.d/docker-compose
}

updateDwm() {
	cp suckless/dwm-6.3/* dwm-6.3
	sudo cp suckless/dwm-6.3/config.def.h dwm-6.3/config.h
	cd dwm-6.3 && sudo make install
	cd ..
}

updateDmenu() {
	cp suckless/dmenu-5.1/config.def.h dmenu-5.1
	sudo cp suckless/dmenu-5.1/config.def.h dmenu-5.1/config.h
	cd dmenu-5.1 && sudo make install
	cd ..
}

updateDwmblock() {
	sudo cp suckless/dwmblocks/blocks.h dwmblocks
	cd dwmblocks && sudo make install
	cd ..
}

installSuckless() {
	# dwm
	wget https://dl.suckless.org/dwm/dwm-6.3.tar.gz
	tar -xf dwm-6.3.tar.gz
	rm -rf dwm-6.3.tar.gz
	updateDwm

	sudo touch /usr/share/xsessions/dwm.desktop
	echo "[Desktop Entry]
Encoding=UTF-8
Name=Dwm
Comment=the dynamic window manager
Exec=dwm
Icon=dwm
Type=XSession" | sudo tee --append /usr/share/xsessions/dwm.desktop

	# dmenu
	wget https://dl.suckless.org/tools/dmenu-5.1.tar.gz
	tar -xf dmenu-5.1.tar.gz
	rm -rf dmenu-5.1.tar.gz
	updateDmenu

	#dwmblocks
	git clone https://github.com/torrinfail/dwmblocks.git
	updateDwmblock
}

while getopts ":i:u:h" o; do case "${o}" in
	h) printf "Optional arguments for custom use:
	-i: install something (support: chrome, vscode, latex, ibus, zsh, git, curl, buildtools, fnm, wget, suckless, flameshot, docker, docker-compose )
	-u: update something (support: dwm, dwmblock, dmenu)
	-h: Show this message\\n" && exit 1 ;;
	i) case ${OPTARG} in "chrome")
		installGoogleChrome
		echo "Done install Google Chrome"
		break
		;;
	"vscode")
		installVSCode
		echo "Done install VSCode"
		break
		;;
	"latex")
		installLatex
		echo "Done install Latex"
		break
		;;
	"ibus")
		installIBus
		echo "Done install ibus"
		break
		;;
	"flameshot")
		installFlameshot
		echo "Done install flameshot"
		break
		;;
	"docker")
		installDocker
		echo "Done install docker"
		break
		;;
	"docker-compose")
		installDockerCompose
		echo "Done install docker-compose"
		break
		;;
	*)
		echo "Sorry, Haven't support it yet!"
		;;
	esac ;;
	u) case ${OPTARG} in "dwm")
		updateDwm
		echo "Done update dwm"
		break
		;;
	"dwmblocks")
		updateDwmblock
		echo "Done upate dwmblocks"
		break
		;;
	*)
		echo "Sorry, Haven't support it yet!"
		;;
	esac ;;
	*) printf "Invalid option: -%s\\n" "$OPTARG" && exit 1 ;;
	esac done
