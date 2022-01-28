{lib, ...}:
let 
 truthy = x: if x == false then false else true;
 dirPathsRecursive = path:
 lib.mapAttrsFlatten
 (name: type:
 if type == "directory" then
 let combinedPath = "${path}/${name}";
 in ([combinedPath] ++ dirPathsRecursive combinedPath)
 else false)
 (builtins.readDir path);
in
path: builtins.filter truthy (lib.flatten (dirPathsRecursive path))


