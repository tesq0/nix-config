{ config, pkgs, ... }:

{

  config = {

    environment.systemPackages = with pkgs; [
      nix-doc
    ];

    environment.variables = {
      TERMINAL="st";
      TERM="xterm-256color";
      MAIL="thunderbird";
    };

    environment.sessionVariables = {
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

      r=''ranger --choosedir=$HOME/.rangerdir; cd (cat $HOME/.rangerdir)'';
      
    };

    environment.extraInit = ''
      # Use librsvg's gdk-pixbuf loader cache file as it enables gdk-pixbuf to load SVG files (important for icons)
      export GDK_PIXBUF_MODULE_FILE="$(echo ${pkgs.librsvg.out}/lib/gdk-pixbuf-2.0/*/loaders.cache)"
    '';

    # Fish Shell
    programs.fish = {
      enable = true;
    };

  };
  
}
