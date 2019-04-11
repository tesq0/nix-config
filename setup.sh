#!/usr/bin/env bash

function nix-packages() {
		git submodule update --init
		git submodule update --remote

		for file in $(find $HOME/.nix-defexpr/*); do
				echo "Removing $file"
				rm $file
		done

		pkgs=$(pwd)./nixpkgs
		echo "Linking $pkgs to $HOME/.nix-defexpr/nixpkgs"
		ln -s $pkgs ~/.nix-defexpr/nixpkgs
}

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
		if [ ! -e $HOME/.homesick/repos/homeshick ]; then
				echo "Installing homehsick"
				git clone --depth=1 https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
		else
				echo "Homeshick already installed, skipping..."
		fi
		alias homeshick="$HOME/.homesick/repos/homeshick/bin/homeshick"
		homeshick clone https://github.com/tesq0/dotfiles.git
}

function all() {
		nix-packages
		nix
		dotfiles
}

case $1 in
		nixpkgs)
				nix-packages
				;;
		nix)
				nix
				;;
		dotfiles)
				dotfiles
				;;
		all)
				all
				;;
		*)
				echo "Pass an argument. Avaliable args: nix, dotfiles"
				;;
esac

