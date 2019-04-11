{ config, pkgs, ... }:

{

  services.xrdp.enable = true;
  services.xrdp.port = 3389;
  services.xrdp.defaultWindowManager = "${pkgs.i3}/bin/i3";

}
