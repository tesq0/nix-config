{ config, pkgs, ... }:

{

  services.openvpn.servers = {
    poland = {
      config = builtins.readFile /media/WINDOWS_DATA/vpn/my_expressvpn_poland_udp.ovpn;
      autoStart = true;
      updateResolvConf = true;
      authUserPass = {
        username = builtins.readFile /media/WINDOWS_DATA/vpn/username;
        password = builtins.readFile /media/WINDOWS_DATA/vpn/password;
      };
    };
  };

}
