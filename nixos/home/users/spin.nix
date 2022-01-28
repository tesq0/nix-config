{ pkgs, lib, ... }:

let
  chromeWayland = pkgs.writeTextFile {
    name = "chrome";
    destination = "/bin/google-chrome-stable";
    executable = true;
    text = ''
      #! ${pkgs.bash}/bin/bash
      ${pkgs.google-chrome}/bin/google-chrome-stable --enable-features=UseOzonePlatform --ozone-platform=wayland
    '';
  };
  mkEmacs = (import ../emacs.nix {inherit pkgs lib;});
  emacsConfig = mkEmacs { package = pkgs.emacsPgtkGcc; };
in
{

  home.packages = [
    chromeWayland
  ];

  home.file.".config/fish/conf.d/sway.fish".text = ''
    set TTY1 (tty)
    [ "$TTY1" = "/dev/tty1" ] && exec sway
  '';

  xsession = {
    pointerCursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata Classic";
      size = 24;
    };
  };

} // emacsConfig
