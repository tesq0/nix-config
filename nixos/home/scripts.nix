{ pkgs, lib, ... }:

# WIP
let
  pwd = builtins.toString ./.;
  mkAttrName = x: outDir: "home.files.\"${outDir}/${x}\".source";
  mkAbsolutePath = x: outDir: "${outDir}/${x}";
  homeFilesRecursive = outDir: dir: lib.mapAttrs'
  (name: val: 
  if val == "directory" then
  homeFilesRecursive "${outDir}/${name}" "${dir}/${name}" # 
  else
  lib.nameValuePair
  (mkAttrName outDir name) 
  (mkAbsolutePath outDir name))
  (builtins.readDir dir);
in
homeFilesRecursive ".scripts" "${pwd}/scripts"
