{ pkgs, lib, ... }:

let
  pwd = builtins.toString ./.;
in
{

  imports =
    (if lib.pathExists "${pwd}/users/current.nix"
    then [ ./users/current.nix ]
    else [ ./users/default.nix ])
    ++ [ ./buildDotfiles.nix ];

  home.packages = [
    pkgs.htop
  ];

  xdg.configFile."mimi/mime.conf".text = ''
    text/: emacsclient -n
    application/pdf: zathura
    video/: mpv
    image/: sxiv
    audio/: mpv
    application/x-tar: st -e atool --list
    application/x-gzip: st -e atool --list
    application/x-bzip2: st -e atool --list
    application/x-rar: st -e atool --list
    application/x-xz: st -e atool --list
    application/zip: st -e atool --list
    inode/directory: st -e ranger
    application/x-directory: st -e ranger
    x-scheme-handler/: google-chrome-stable
  '';

  # xdg.configFile."nix/nix.conf".text = ''
  #   experimental-features = nix-command flakes
  # '';

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      # Emacs 28
      url = https://github.com/nix-community/emacs-overlay/archive/4dab9845b372f4cc335a6009b0766c5165ef7c93.tar.gz;
    }))
  ];

  programs.home-manager.enable = true;

  programs.nix-index.enable = true;
  programs.nix-index.enableFishIntegration = true;

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  # optional for nix flakes support
  programs.direnv.nix-direnv.enableFlakes = true;

  programs.tmux = {
    enable = true;
    extraConfig = ''
      set -g mouse on
    '';
  };

  programs.ssh = {
    enable = true;
    matchBlocks = (if lib.pathExists "${pwd}/matchBlocks.nix" then (import ./matchBlocks.nix) else {}); 
  };

  xresources.properties = {
    "Xcursor.theme" = "Adwaita";
    "Xft.autohint" = 0;
    "Xft.lcdfilter" = "lcddefault";
    "Xft.hintstyle" = "hintslight";
    "Xft.hinting" = 1;
    "Xft.antialias" = 1;
    "Xft.rgba" = "rgb";
  };

}
