{ config, pkgs, ... }:

{
  
  imports = [ ../../environment.nix ];

  environment.variables = {
    TERMINAL="st";
    TERM="xterm-256color";
    BROWSER="chromium-browser";
    MAIL="thunderbird";
    MPD_HOST="localhost";
    SUDO_ASKPASS="dmenupass";
  };
}
