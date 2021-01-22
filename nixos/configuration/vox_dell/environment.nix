{ config, pkgs, ... }:

let
  overlays = (import ../../../overlays/all-overlays.nix { }) pkgs;
in
{
  
  imports = [ ../../environment.nix ];

  environment.variables = {
    BROWSER="chromium-browser";
  };

  systemd.services.voxvpn = {
    description = "Connect to vox vpn";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${overlays.openfortivpn}/bin/openfortivpn --use-syslog --persistent=3 -c /home/vox_miki/.vpn/vox.conf";
      KillMode = "mixed";
      TimeoutStopSec= 2;
      RestartSec = 20;
      Restart = "on-failure";
    };
  };

}
