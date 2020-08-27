{ lib, fetchFromGitHub, buildPythonApplication, i3ipc, pynput }:

buildPythonApplication rec {

  pname = "i3-unity-fix";
  version = "0.1.2";

  src = fetchFromGitHub {
      owner = "tesq0";
      repo = "i3-unity-fix";
      rev = "v${version}";
      sha256 = "1kysbvvf1i6l0lhj3bvch7mccah41mwaiq7f3h8dbm8d95qwm86z";
  };

  propagatedBuildInputs = [ i3ipc pynput ];

  doCheck = false;
  
}
