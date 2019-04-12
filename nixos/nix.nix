{ config, pkgs, ... }:

{
  nix = {
    extraOptions = ''
      auto-optimise-store = true
      gc-keep-outputs = true
    '';
    nixPath = [
      "nixpkgs=/home/mikus/.nix-config/nixpkgs"
      "nixos-config=/etc/nixos/configuration.nix"
    ];
    useSandbox = true;
  };
}
