{ pkgs, ... }:

{
  home.packages = [
    pkgs.htop
    pkgs.fortune
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
  '';

  programs.emacs = {
    enable = true;
    package = pkgs.emacs27.overrideAttrs (old: rec {
      nativeComp = true;
    });
    extraPackages = epkgs: [
      epkgs.nix-mode
      epkgs.magit
      epkgs.magit

      epkgs.company
      # epkgs.company-etags
      epkgs.company-prescient

      # epkgs.arduino-mode
      # epkgs.company-arduino

      epkgs.nasm-mode
      epkgs.x86-lookup

      epkgs.cider
      epkgs.flycheck-clojure

      epkgs.omnisharp

      epkgs.dart-mode
      epkgs.flutter

      # epkgs.dictionary
      epkgs.google-translate

      epkgs.dired-ranger
      epkgs.diredfl
      # epkgs.dired-x

      epkgs.eldoc

      epkgs.undo-tree
      epkgs.evil
      epkgs.avy
      epkgs.evil-surround
      epkgs.evil-nerd-commenter
      epkgs.drag-stuff
      epkgs.evil-visualstar

      epkgs.flycheck

      epkgs.general

      epkgs.gdscript-mode

      epkgs.helm
      epkgs.helm-xref

      # epkgs.hideshow

      # epkgs.hippie-expand

      epkgs.ace-window

      epkgs.hydra

      epkgs.fullframe
      epkgs.ibuffer-vc

      epkgs.groovy-mode
      # epkgs.lsp-java

      # epkgs.dump-jump
      # epkgs.smart-jump

      epkgs.kotlin-mode
      epkgs.flycheck-kotlin

      epkgs.lsp-mode
      # epkgs.company-lsp
      epkgs.lsp-ui
      epkgs.dap-mode

    ];
  };

  services.emacs = {
    enable = true;
  };

  programs.home-manager.enable = true;

}
