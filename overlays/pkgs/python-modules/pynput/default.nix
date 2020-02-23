{ lib, buildPythonPackage, fetchPypi, sphinx, setuptools-lint, pylint, xlib, rpyc }:

buildPythonPackage rec {
  pname = "pynput";
  version = "1.6.0";

  buildInputs = [ sphinx setuptools-lint pylint xlib rpyc ];
  
  src = fetchPypi {
    inherit pname version;
    sha256 = "1f4y94rj76vvs84c693qyiwl0d287563ymr0vzvkjj1x088nhhc0";
  };
  
  doCheck = false;

}
