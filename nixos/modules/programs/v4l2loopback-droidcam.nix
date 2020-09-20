{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.programs.droidcam;
  overlays = (import ../../../overlays/all-overlays.nix { }) pkgs;
  # grep -F "[Loopback" < /proc/asound/cards | awk '{print $1}'
  LOOPBACK_CARD_ID = "4";
in
{
  options = {
    programs.droidcam = {
      enable = mkEnableOption "The GNU/Linux client is a combination of a Video4Linux2 device driver and an executable app that will transfer the stream from the phone to the driver.";
    };
  };

  config = mkIf cfg.enable {
    
    boot.extraModulePackages = [ overlays.v4l2loopback-droidcam ];
    boot.kernelModules = [ "videodev" "v4l2loopback_dc" "snd-aloop" ];
    boot.extraModprobeConfig = ''
      options v4l2loopback_dc width=1920 height=1080
      # options v4l2loopback_dc width=1280 height=720
      # options v4l2loopback_dc width=640 height=480
      options snd-aloop index=${LOOPBACK_CARD_ID}
    '';

    environment.systemPackages = [ overlays.droidcam ];
    
  };

  meta = {
    maintainers = with lib.maintainers; [ tesq0 ];
  };
}
