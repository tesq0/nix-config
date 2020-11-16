{ config, pkgs, ... }:

{
  
  imports = [ ../../environment.nix ];

  environment.variables = {
    BROWSER="firefox";
  };



  systemd.services.voxvpn = {
    description = "Connect to vox vpn";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.openfortivpn}/bin/openfortivpn --use-syslog --persistent=3 -c /home/vox_miki/.vpn/vox.conf";
      RestartSec = 6;
      Restart = "always";
    };
  };

  systemd.user.services.voxdb-sshtunnel = {
    description = "Ssh tunnel for vox mysql database";
    after = [ "network.target" ];
    wantedBy = [ "default.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.openssh}/bin/ssh -o StrictHostKeyChecking=no -vvv -i /home/vox_miki/.ssh/voxteam_rsa -N -L 3306:127.0.0.1:3306 mgalkowski@voxteam.pl";
      RestartSec = 6;
      Restart = "no";
    };
  };


}
