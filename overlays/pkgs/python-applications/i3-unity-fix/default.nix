{ lib, fetchFromGitHub, buildPythonApplication, i3ipc, pynput }:

buildPythonApplication rec {

  pname = "i3-unity-fix";
  version = "0.1.2";

  src = fetchFromGitHub {
      owner = "tesq0";
      repo = "i3-unity-fix";
      rev = "v${version}";
      sha256 = "0n7kp8mvxmarsw7djf05jv0syypfa0c2ffychzgbyc9789s1b0gg";
  };

  propagatedBuildInputs = [ i3ipc pynput ];

  doCheck = false;
  
}
