{ config, pkgs, ... }:

{
  nix = {
    extraOptions = ''
      auto-optimise-store = true
      gc-keep-outputs = true
      binary-caches-parallel-connections = 3
      connect-timeout = 5

      keep-outputs = true
      keep-derivations = true
      experimental-features = nix-command flakes
    '';
    nixPath = [
      "nixpkgs=/etc/nixos/nixpkgs"
      "nixpkgs-overlays=/etc/nixos/overlays"
      "nixos-config=/etc/nixos/configuration.nix"
    ];
    useSandbox = true;
    package = pkgs.nixFlakes;
  };
}
