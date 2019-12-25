{ lib, buildPythonPackage, fetchPypi, rpyc, python-daemon, pykeepass, pynput }:

buildPythonPackage rec {

  pname = "pykeepass-cache";
  version = "3";
  
  buildInputs = [ rpyc python-daemon pykeepass pynput ];

  src = fetchPypi {
    inherit pname version;
    sha256 = "1gn119hccwhkaxg9zb251g49k56ac6ifwp2wwaydw1zlwzv2imdl";
  };
  
  doCheck = false;

}
