{ lib, ... }:

# let
#   pwd = builtins.toString ./.;
#   mkAttrName = outDir: fname: "${outDir}/${fname}";
#   mkAbsolutePath = outDir: fname: ./${outDir}/${fname};
#   filesRecursive = outDir: dir: lib.mapAttrsFlatten
#   (name: fileType:
#   if fileType == "directory"
#   then
#   filesRecursive  "${outDir}/${name}" "${dir}/${name}"
#   else
#   lib.nameValuePair
#   (mkAttrName outDir name)
#   { source = (mkAbsolutePath outDir name); })
#   (builtins.readDir dir);
{
  home.file.".scripts" = {
    source = ./scripts;
    recursive = true;
  };
    # builtins.listToAttrs (lib.flatten (filesRecursive ".scripts" "${pwd}/scripts"));
}

