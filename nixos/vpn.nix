{ config, pkgs, ... }:

let
  routeScript = ''
    #! /bin/sh
    ${pkgs.iproute}/bin/ip route add default via $route_vpn_gateway
    ${pkgs.iproute}/bin/ip route del 0.0.0.0/1 via $route_vpn_gateway
    ${pkgs.iproute}/bin/ip route del 128.0.0.0/1 via $route_vpn_gateway
  '';
  autoRestartScript = ''
    #!/bin/sh
    ping -c 1 -I tun0 10.8.0.1 &> /dev/null
    code=$?
    if [ $code -ne 0 ]; then
    systemctl restart openvpn-jazajuk.service
    fi
  '';
in
{
  
  services.openvpn.servers = {
    jazajuk = {
      config = ''
        config /root/nixos/openvpn/mikus.ovpn
        route-up ${pkgs.writeScript "openvpn-jazajuk-route-up" routeScript}
      '';
      autoStart = true;
      updateResolvConf = true;
    };

    legalink = {
      config = ''
        config /root/nixos/openvpn/legalink.ovpn
        route-up ${pkgs.writeScript "openvpn-jazajuk-route-up" routeScript}
      '';
      autoStart = true;
    };
    
  };

  
  systemd.services.rovpnd = {
    description = "Auto restart openvpn service";
    after = [ "network.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.writeScript "rovpnd" autoRestartScript}";
      RestartSec = 6;
      Restart = "always";
    };
  };
  
}
