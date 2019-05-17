{ config, pkgs, ... }:

{
  
  services.openvpn.servers = {
    jazajuk = {
      config = ''config /root/nixos/openvpn/vpn-jazajuk.ovpn'';
      autoStart = true;
      updateResolvConf = true;
    };
  };
  
}
