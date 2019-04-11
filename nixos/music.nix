{ config, pkgs, ... }:

{

  services.mpd = {
    enable = true;
    startWhenNeeded = true;
    musicDirectory = /media/WINDOWS_DATA/Stuff/Music;
    extraConfig = ''
        audio_output {
          type    "alsa"
          name    "Local MPD"
          mixer_type "software"
        }
    '';
  };

}
