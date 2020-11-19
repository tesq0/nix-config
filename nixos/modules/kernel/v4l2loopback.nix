{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.kernel.v4l2loopback;
in
{
  options = {
    kernel.v4l2loopback = {
      enable = mkEnableOption "Video4Linux2 device driver kernel module.";
      videoNr = mkOption {
        default = "20";
        type = types.str;
        description = ''
          video device number /dev/video{number}
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    
    boot.extraModulePackages = with pkgs.linuxPackages; [ v4l2loopback ];
    boot.kernelModules = [ "videodev" "v4l2loopback" ];
    boot.extraModprobeConfig = ''
      options v4l2loopback devices=1 exclusive_caps=1 video_nr=${cfg.videoNr} card_label="v4l2loopback"
    '';
    
  };

  meta = {
    maintainers = with lib.maintainers; [ tesq0 ];
  };
}
