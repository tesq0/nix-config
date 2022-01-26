{ config, pkgs, ... }:

{
  
  imports = [ ../../environment.nix ];

  config = {
    environment.systemPackages = (import ../../packages.nix pkgs);
    environment.sessionVariables = {
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    };
  };
  
}
