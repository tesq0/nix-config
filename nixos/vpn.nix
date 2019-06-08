{ config, pkgs, ... }:

let
  routeScript = ''
    #! /bin/sh
    ${pkgs.iproute}/bin/ip route add default via $route_vpn_gateway
    ${pkgs.iproute}/bin/ip route del 0.0.0.0/1 via $route_vpn_gateway
    ${pkgs.iproute}/bin/ip route del 128.0.0.0/1 via $route_vpn_gateway
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
  };
  
}
