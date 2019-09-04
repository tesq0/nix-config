{ config, pkgs, ... }:

let home = "/home/mikus";
in
{

  # List packages installed in system profile. To search, run:
  # $ nix search wgt

  environment.systemPackages = (import ./packages.nix pkgs);

  programs.wireshark.enable = true;
  
  environment.variables = {
    TERMINAL="st";
    TERM="xterm-256color";
    BROWSER="pcmanfm";
    MAIL="firefox";
    MPD_HOST="localhost";
    # XCURSOR_PATH = [
    #   "${config.system.path}/share/icons"
    #   "${home}/.icons"
    #   "${home}/.nix-profile/share/icons/"
    # ];
  };

  # Use librsvg's gdk-pixbuf loader cache file as it enables gdk-pixbuf to load SVG files (important for icons)
  environment.sessionVariables = {
    GDK_PIXBUF_MODULE_FILE = "$(echo ${pkgs.librsvg.out}/lib/gdk-pixbuf-2.0/*/loaders.cache)";
    XDG_CURRENT_DESKTOP="GNOME";
    QT_SELECT="5";
    GTK_IM_MODULE="";
  };

  environment.shellAliases = {

    # Wine
    wine32="env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine";
    wine32cfg="env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 winecfg";
    w32="WINEARCH=win32 WINEPREFIX=$HOME/.wine32";
    winetricks32="env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 winetricks";

    # Util
    sdn="sudo shutdown now";
    mkd="mkdir -pv";
    crep="grep --color=always";
    la="ls -al";
    ll="ls -l";
    ka="killall";
    c="clear";
    e="exit";
    
    # Git
    gms="git merge -Xignore-all-space";
    gmsc="git merge -Xignore-all-space --no-commit";
    gm="git merge";
    gs="git status";
    gch="git checkout";

    gfo="git fetch origin";

    gdiscardAll="git checkout .";

    gdiscardShit="git checkout '*.mat *.asset *.spriteatlas *.prefab'";

    fetchdev="git fetch origin develop:develop";
    mergedev="git merge develop";

    gcom="git commit -m";

    gcomall="git add --all && git commit -m";

    gpl="git pull";
    gpu="git push";
    
  };

  environment.extraInit = ''
    export PATH="$(du ${home}/.scripts/ | cut -f2 | tr '\n' ':')$PATH"
    export PATH="${home}/.npm-global/bin:$PATH"
  '';

  services.transmission.enable = true;

  # Fish Shell
  programs.fish = {
    enable = true;
  };

}
