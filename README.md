# NixOS Config

Installation :

1. `git clone --recurse-submodules git@github.com:tesq0/nix-config.git ~/.nix-config`

2. Check the configuration files in the nixos folder and adjust them to your needs

3. run `./setup.sh all` or specific components of setup.sh:

* `./setup.sh nixpkgs` sets up my nixpkgs fork
* `sudo ./setup.sh nix links everything in nixos/* to /etc/nixos/`
* `./setup.sh dotfiles downloads and links my dotfiles to your home dir`
