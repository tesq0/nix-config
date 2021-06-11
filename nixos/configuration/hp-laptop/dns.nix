{ config, lib, pkgs, ... }:
{
  config = {
    services.dnsmasq = {
      enable = true;
      servers = [
        "208.67.222.222"
        "208.67.220.220"
      ];
      extraConfig = ''
        addn-hosts=${./extra-hosts.txt}
      '';
    };
  };
}
