#!/usr/bin/env bash

function nix-packages() {
    git submodule update --init
    git submodule update --remote

    for file in $(find $HOME/.nix-defexpr/ -type f); do
	echo "Removing $file"
	rm $file
    done

    pkgs=$(pwd)/nixpkgs
    echo "Linking $pkgs to $HOME/.nix-defexpr/nixpkgs"
    ln -s $pkgs $HOME/.nix-defexpr/nixpkgs
}

function nix() {
    echo "Link nix config"

    [ ! -e "/etc/nixos" ] && sudo mkdir -p /etc/nixos

    dir=$(pwd)
    
    PS3='Please choose the configuration: '
    configurations=$(ls $dir/nixos/configuration)
    options=($configurations "Quit")
    str_options="${options[@]}"

    select opt in $str_options
    do
	if [ -z "${opt}" ] ; then
	    echo "invalid option $REPLY";
	    break;
	fi;
	case $opt in
	    "Quit")
		break
		;;
	    *)
		sudo ln -svf "$dir/nixos/configuration/${opt}/configuration.nix" /etc/nixos/;
		break;
		;;
	esac
    done
    
    sudo ln -svf "$dir/overlays" /etc/nixos/
    sudo ln -svf "$dir/nixpkgs" /etc/nixos/

}

function home() {

    cd $(dirname $0)

    mkdir -p ~/.config/nixpkgs

    ln -sf $(pwd)/nixos/home/home.nix ~/.config/nixpkgs/home.nix

    if [ -z "$(nix-channel --list | awk /home-manager/)" ]; then
        echo "Adding home-manager channel"
	nix-channel --add 'https://github.com/nix-community/home-manager/archive/release-21.05.tar.gz' home-manager
	nix-channel --update

    fi

    if [ -z "$(command -v home-manager)" ]; then
	echo "install home-manager"
	nix-shell '<home-manager>' -A install
    fi

}

function dotfiles() {
    if [ ! -e "$HOME/.homesick/repos/homeshick" ]; then
	echo "Installing homehsick"
	git clone --depth=1 https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
	homeshick="$HOME/.homesick/repos/homeshick/bin/homeshick"
	$homeshick clone git@github.com:tesq0/dotfiles.git
    else
	echo "Homeshick already installed, skipping..."
    fi
}

function all() {
    nix-packages
    nix
    dotfiles
    home
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
    home)
	home
	;;
    all)
	all
	;;
    *)
	echo "Pass an argument. Avaliable args: nix, dotfiles"
	;;
esac

