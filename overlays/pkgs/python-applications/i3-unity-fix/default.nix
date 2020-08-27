{ lib, fetchFromGitHub, buildPythonApplication, i3ipc, pynput }:

buildPythonApplication rec {

  pname = "i3-unity-fix";
  version = "0.1.2";

  src = fetchFromGitHub {
      owner = "tesq0";
      repo = "i3-unity-fix";
      rev = "v${version}";
      sha256 = "1x0sr6frzlmv77hv54a5m8s9rz9lavlwyjnhhm5imsszliaz13jl";
  };

  propagatedBuildInputs = [ i3ipc pynput ];

  doCheck = false;
  
}
