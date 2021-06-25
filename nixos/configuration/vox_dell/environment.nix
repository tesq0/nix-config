{ config, pkgs, ... }:

let
  overlays = (import ../../../overlays/all-overlays.nix { }) pkgs;
  pwd = builtins.toString ./.;
in
{
  
  imports = [ ../../environment.nix ];
  
  systemd.services.voxvpn = {
    description = "Connect to vox vpn";
    after = [ "network.target" ];
    # wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "vpn.sh";
      KillMode = "mixed";
      TimeoutStopSec= 2;
      RestartSec = 20;
      Restart = "on-failure";
    };
  };

}
