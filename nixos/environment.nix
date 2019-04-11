{ config, pkgs, ... }:

{

  # List packages installed in system profile. To search, run:
  # $ nix search wgt

  environment.systemPackages = (import ./packages.nix pkgs);
  
  environment.variables = {
    TERMINAL="konsole";
    TERM="xterm-256color";
    BROWSER="dolphin";
    MAIL="chromium";
    MPD_HOST="localhost";
    XCURSOR_PATH = [
      "${config.system.path}/share/icons"
      "$HOME/.icons"
      "$HOME/.nix-profile/share/icons/"
    ];
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
    export PATH="$(du $HOME/.scripts/ | cut -f2 | tr '\n' ':')$PATH"
    export PATH="/home/mikus/.npm-global/bin:$PATH"
    export NIX_PATH="mypkgs=/home/mikus/Documents/Projects/nixpkgs:$NIX_PATH"
    nvidia-settings --load-config-only --config $HOME/.nvidia-settings-rc
  '';

  # Fish Shell
  programs.fish = {
    enable = true;
  };

}
