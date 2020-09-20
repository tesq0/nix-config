{ config, pkgs, ... }:

{
  
  imports = [ ../../environment.nix ];

  environment.variables = {
    BROWSER="firefox";
  };

}
