{ config, pkgs, ... }:

{

  services.openvpn.servers = {
    poland = {
      config = builtins.readFile /media/STORAGE/vpn/my_expressvpn_poland_udp.ovpn;
      autoStart = true;
      updateResolvConf = true;
      authUserPass = {
        username = builtins.readFile /media/STORAGE/vpn/username;
        password = builtins.readFile /media/STORAGE/vpn/password;
      };
    };
  };

}
