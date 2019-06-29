{ config, pkgs, ... }:

{
  
  services.syncthing = {
    enable = true;
    user = "mikus";
    dataDir = "/home/mikus/.config/syncthing";
  };
  
}
