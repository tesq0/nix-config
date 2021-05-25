{ config, lib, pkgs, ... }:
{
  config = {
    services.dnsmasq = {
      enable = true;
      servers = [
        "/remotevpn2.vox.pl/208.67.222.222"
        "/vox.pl/10.118.80.90"
        "/voxteam.pl/10.118.80.90"
        "/vox.pl/10.8.12.90"
        "/voxteam.pl/10.8.12.90"
        "208.67.222.222"
        "208.67.220.220"
      ];
    };
  };
}
