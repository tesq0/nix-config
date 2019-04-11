#!/usr/bin/env bash

function nix() {
		echo "Link nix config"
		mkdir -p /etc/nixos
		dir=$(pwd)
		for file in $(find $dir/nixos/*) ; do
				echo "Link $file to /etc/nixos/"
				ln -sf $file /etc/nixos/
		done;
}

function dotfiles() {
		if [ ! -f $HOME/.homesick/repos/homeshick ]; then
				echo "Installing homehsick"
				git clone --depth=1 https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
		else
				echo "Homeshick already installed, skipping..."
		fi
		alias homeshick="$HOME/.homesick/repos/homeshick/bin/homeshick"
		homeshick clone https://github.com/tesq0/dotfiles.git
}

case $1 in
		nix)
				nix
				;;
		dotfiles)
				dotfiles
				;;
		*)
				echo "Pass an argument. Avaliable args: nix, dotfiles"
				;;
esac

