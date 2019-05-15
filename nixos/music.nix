{ config, pkgs, ... }:

{

  services.mpd = {
    enable = true;
    startWhenNeeded = true;
    musicDirectory = "/media/STORAGE/Audio";
    extraConfig = ''
        audio_output {
          type    "alsa"
          name    "Local MPD"
          mixer_type "software"
        }
    '';
  };

}
