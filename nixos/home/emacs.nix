{ pkgs, lib, ... }:
{ package ? pkgs.emacsGcc }:
{
  programs.emacs = {
    enable = true;
    package = package;
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
}
