{lib, ...}:

let
  dotfilesPath = ./dotfiles;
in
{
  home.file = lib.mapAttrs
  (fileName: fileType: {
    source = "${dotfilesPath}/${fileName}";
    recursive = if fileType == "directory" then true else false;
  })
  (builtins.readDir dotfilesPath);
}
