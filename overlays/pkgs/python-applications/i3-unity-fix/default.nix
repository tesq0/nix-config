{ lib, fetchFromGitHub, buildPythonApplication, i3ipc, pynput }:

buildPythonApplication rec {

  pname = "i3-unity-fix";
  version = "0.1.1";

  src = fetchFromGitHub {
      owner = "tesq0";
      repo = "i3-unity-fix";
      rev = "v${version}";
      sha256 = "1f4frnxfg8l83c3aiiff1p4rqc6qy7ry7w3gcgs50mp30sinl0f2";
  };

  propagatedBuildInputs = [ i3ipc pynput ];

  doCheck = false;
  
}
