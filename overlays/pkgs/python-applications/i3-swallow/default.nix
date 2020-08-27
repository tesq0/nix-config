{ lib, buildPythonApplication, i3ipc }:

buildPythonApplication rec {

  pname = "i3-swallow";
  version = "1";

  src = ./src;

  propagatedBuildInputs = [ i3ipc ];

  doCheck = false;
  
}
