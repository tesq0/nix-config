{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.programs.droidcam;
  drivers = [ "videodev" "v4l2loopback_dc" ];
  overlays = (import ../../../overlays/all-overlays.nix { }) pkgs;
in
{
  options = {
    programs.droidcam = {
      enable = mkEnableOption "The GNU/Linux client is a combination of a Video4Linux2 device driver and an executable app that will transfer the stream from the phone to the driver.";
    };
  };

  config = mkIf cfg.enable {
    
    boot.extraModulePackages = [ overlays.v4l2loopback-droidcam ];
    boot.kernelModules = [ "videodev" "v4l2loopback_dc" ];
    boot.extraModprobeConfig = ''
      options v4l2loopback_dc width=640 height=480
    '';

    environment.systemPackages = [ overlays.droidcam ];
    
  };

  meta = {
    maintainers = with lib.maintainers; [ tesq0 ];
  };
}
