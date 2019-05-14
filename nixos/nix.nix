{ config, pkgs, ... }:

{
  nix = {
    extraOptions = ''
      auto-optimise-store = true
      gc-keep-outputs = true
    '';
    nixPath = [
      "nixpkgs=/etc/nixos/nixpkgs"
      "nixpkgs-overlays=/etc/nixos/overlays"
      "nixos-config=/etc/nixos/configuration.nix"
    ];
    useSandbox = true;
  };
}
