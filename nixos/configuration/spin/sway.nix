{ config, pkgs, lib, ... }: {
  config = {
    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true; # so that gtk works properly
      extraPackages = with pkgs; [
        swaylock # lockscreen
        swayidle
        waybar # status bar
        mako # notification daemon
        kanshi # autorandr
        wofi
        alacritty
      ];
      extraSessionCommands = ''
        export TERMINAL=alacritty
        # SDL:
        export SDL_VIDEODRIVER=wayland
        # QT (needs qt5.qtwayland in systemPackages):
        export QT_QPA_PLATFORM=wayland-egl
        export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"

        # Fix for some Java AWT applications (e.g. Android Studio),
        # use this if they aren't displayed properly:
        export _JAVA_AWT_WM_NONREPARENTING=1
      '';
    };

    # Here we but a shell script into path, which lets us start sway.service (after importing the environment of the login shell).
    environment.systemPackages = with pkgs; [
      (
        pkgs.writeTextFile {
          name = "startsway";
          destination = "/bin/startsway";
          executable = true;
          text = ''
            #! ${pkgs.bash}/bin/bash

            # first import environment variables from the login manager
            systemctl --user import-environment
            # then start the service
            exec systemctl --user start sway.service
          '';
        }
      )
      qt5.qtwayland
      lxappearance
      wl-clipboard
      brightnessctl
      xdg-desktop-portal-wlr
    ];

    systemd.user.targets.sway-session = {
      description = "Sway compositor session";
      documentation = [ "man:systemd.special(7)" ];
      bindsTo = [ "graphical-session.target" ];
      wants = [ "graphical-session-pre.target" ];
      after = [ "graphical-session-pre.target" ];
    };

    systemd.user.services.sway = {
      description = "Sway - Wayland window manager";
      documentation = [ "man:sway(5)" ];
      bindsTo = [ "graphical-session.target" ];
      wants = [ "graphical-session-pre.target" ];
      after = [ "graphical-session-pre.target" ];
      # We explicitly unset PATH here, as we want it to be set by
      # systemctl --user import-environment in startsway
      environment.PATH = lib.mkForce null;
      serviceConfig = {
        Type = "simple";
        ExecStart = ''
          ${pkgs.dbus}/bin/dbus-run-session ${pkgs.sway}/bin/sway --debug
        '';
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };

    services.redshift = {
      enable = true;
      package = pkgs.redshift-wlr;
    };

    systemd.user.services.kanshi = {
      description = "Kanshi output autoconfig ";
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      serviceConfig = {
        # kanshi doesn't have an option to specifiy config file yet, so it looks
        # at .config/kanshi/config
        ExecStart = ''
          ${pkgs.kanshi}/bin/kanshi
        '';
        RestartSec = 5;
        Restart = "always";
      };
    };

    systemd.user.services.swayidle = {
      description = "Idle Manager for Wayland";
      documentation = [ "man:swayidle(1)" ];
      wantedBy = [ "sway-session.target" ];
      partOf = [ "graphical-session.target" ];
      path = [ pkgs.bash ];
      serviceConfig = {
        ExecStart = '' ${pkgs.swayidle}/bin/swayidle -w -d \
        timeout 300 '${pkgs.sway}/bin/swaymsg "output * dpms off"' \
        resume '${pkgs.sway}/bin/swaymsg "output * dpms on"'
      '';
      };
    };

  };
}
