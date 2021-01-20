{ config, lib, pkgs, ... }:

{

  config = {
    networking.extraHosts = builtins.readFile ./server-hosts.txt;
  };

}
