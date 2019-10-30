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
    office = {
      config = ''
        config /root/nixos/openvpn/mikolaj.ovpn
      '';
      autoStart = true;
    };
    jazajuk = {
      config = ''
        config /root/nixos/openvpn/mikolaj.ovpn
        route-up ${pkgs.writeScript "openvpn-route-up" routeScript}
      '';
      autoStart = false;
      updateResolvConf = true;
    };
  };
  
}
