{ lib, ... }@args:
let
  callLib = path: import path args;
in
{
  dirPathsRecursive = callLib ./dirPathsRecursive.nix;
}

