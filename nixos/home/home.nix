{ pkgs, lib, ... }:

let
  pwd = builtins.toString ./.;
in
{

  imports =
    (if lib.pathExists "${pwd}/users/current.nix"
    then [ ./users/current.nix ]
    else [])
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

  programs.emacs = {
    enable = true;
    package = pkgs.emacsGcc;
    extraPackages = epkgs: [
      epkgs.use-package
      epkgs.nix-mode
      epkgs.magit
      epkgs.git-gutter

      epkgs.company
      # epkgs.company-etags
      epkgs.company-prescient

      # epkgs.arduino-mode
      # epkgs.company-arduino
      epkgs.shackle
      epkgs.ivy
      epkgs.fzf
      epkgs.rg
      epkgs.nasm-mode
      epkgs.x86-lookup

      epkgs.doom-themes
      epkgs.cider
      epkgs.flycheck-clojure

      epkgs.omnisharp

      epkgs.add-node-modules-path

      epkgs.smartparens
      epkgs.evil-smartparens
      epkgs.dart-mode
      epkgs.flutter

      epkgs.smart-jump
      # epkgs.dictionary
      epkgs.google-translate

      epkgs.dired-ranger
      epkgs.diredfl
      # epkgs.dired-x

      epkgs.eldoc

      epkgs.exec-path-from-shell

      epkgs.web-mode

      epkgs.emmet-mode

      epkgs.undo-tree
      epkgs.evil
      epkgs.evil-mc
      epkgs.avy
      epkgs.evil-surround
      epkgs.evil-nerd-commenter
      epkgs.drag-stuff
      epkgs.evil-visualstar

      epkgs.flycheck

      epkgs.benchmark-init
      epkgs.general

      epkgs.gdscript-mode

      epkgs.helm
      epkgs.helm-company
      epkgs.helm-xref

      epkgs.direnv

      # epkgs.hideshow

      # epkgs.hippie-expand

      epkgs.ace-window

      epkgs.hydra

      epkgs.fullframe
      epkgs.ibuffer-vc

      epkgs.groovy-mode
      epkgs.lsp-java

      # epkgs.dump-jump
      # epkgs.smart-jump

      epkgs.kotlin-mode
      epkgs.flycheck-kotlin

      epkgs.lsp-mode
      # epkgs.company-lsp
      epkgs.lsp-ui
      epkgs.dap-mode

      epkgs.projectile

      epkgs.helm-projectile

      epkgs.benchmark-init

      epkgs.which-key

      epkgs.yasnippet

      epkgs.yasnippet-snippets
      
      epkgs.rainbow-mode

      epkgs.rainbow-delimiters

      epkgs.editorconfig

      epkgs.indium

      (epkgs.trivialBuild rec {
        pname = "evil-magit";
        version = "b5b6ad45130fc04a9fe30c803933e0451bdeace7";
        packageRequires = [
          epkgs.evil
          epkgs.magit
        ];
        src = pkgs.fetchFromGitHub {
          owner = "tesq0";
          repo = "evil-magit";
          rev = "${version}";
          hash = "sha256-DKCIQLh6ACkvfjZmd04DE+ViFAVgKz9mqJ6PDNiOIq8=";
        };
      })

    ];
  };

  #services.emacs = {
  #  enable = true;
  #};

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
