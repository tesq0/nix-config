{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.dj;
in
{

  options.dj = {
    enable = mkEnableOption "DJ Kernel modifications";
    soundcardPciId = mkOption {
      default = "00:1f.3";
      type = types.str;
      description = ''
        The PCI ID of the primary soundcard. Used to set the PCI
        latency timer.

        To find the PCI ID of your soundcard:
            lspci | grep -i audio
      '';
    };
  };

  imports = [ ./musnix ];

  config = mkIf cfg.enable {

    musnix.enable = true;
    musnix.soundcardPciId = cfg.soundcardPciId;
    
    hardware.pulseaudio.enable = true;
    hardware.pulseaudio.support32Bit = true;
    hardware.pulseaudio.package = pkgs.pulseaudioFull;

    environment.systemPackages = with pkgs ; [
      libjack2 jack2 qjackctl
      jack2Full jack_capture
      ardour guitarix hydrogen
    ];

  };
  
}
