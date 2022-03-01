{ pkgs, lib, config, ... }:

let
  localPkgs = import /home/mikus/Projects/nixpkgs {};
  chromeWayland = pkgs.writeTextFile {
    name = "chrome";
    destination = "/bin/google-chrome-stable";
    executable = true;
    text = ''
      #! ${pkgs.bash}/bin/bash
      ${localPkgs.google-chrome}/bin/google-chrome-stable --enable-features=VaapiVideoDecoder --ozone-platform-hint=auto $@
    '';
  };
  mkEmacs = (import ../emacs.nix {inherit pkgs lib;});
  emacsConfig = mkEmacs { package = pkgs.emacsPgtkGcc; };
  gsettings = "${pkgs.glib}/bin/gsettings";
  cursorTheme = "Bibata-Original-Classic";
in
{

  programs.dconf.enable = true;

  home.packages = [
    pkgs.bibata-cursors
    chromeWayland
  ];

  home.file.".config/fish/conf.d/sway.fish".text = ''
    set TTY1 (tty)
    [ "$TTY1" = "/dev/tty1" ] && exec sway
  '';

  home.file.".config/mpv/mpv.conf".text = ''
    hwdec=auto-safe
    vo=gpu
    profile=gpu-hq
    gpu-context=wayland
  '';

  wayland.windowManager.sway = {
    enable = true;
    extraConfig = builtins.readFile ../sway/config;
    wrapperFeatures.gtk = true;
    extraSessionCommands = ''
      export TERMINAL="alacritty";
      export PATH="$PATH''${PATH:+:}"
      export MOZ_ENABLE_WAYLAND=1
    '';
    config = {
      modifier = "Mod4";
      bars = [];
      keybindings = {};
      seat = {
        "*" = {"xcursor_theme" = "'${cursorTheme}' 24";};
      };
      startup = (lib.mapAttrsFlatten (option: value:
      {
        command = "${gsettings} set org.gnome.desktop.interface ${option} '${value}'"; 
        always = true;
      })
      {
        "gtk-theme" = "Numix";
        "icon-theme" = "Numix";
        "cursor-theme" = cursorTheme;
        "font-name" = "Montserrat";
      }) ++ [
        { command = "mako &"; }
        { command = "monitor-notifications ~/.notify.log &"; }
      ];
    };
  };

  services.kanshi = {
    enable = true;
    profiles = {
      docked = {
        outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "DP-2";
          }
        ];
      };
      undocked = {
        outputs = [
          {
            criteria = "eDP-1";
            scale = 1.5;
            status = "enable";
          }
        ];
      };
    };
  };

  xsession = {
    pointerCursor = {
      package = pkgs.bibata-cursors;
      name = cursorTheme;
      size = 24;
    };
  };

} // emacsConfig
