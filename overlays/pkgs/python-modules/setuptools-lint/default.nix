{ lib, buildPythonPackage, fetchPypi, pylint }:

buildPythonPackage rec {
  pname = "setuptools-lint";
  version = "0.6.0";

  buildInputs = [ pylint ];
  
  src = fetchPypi {
    inherit pname version;
    sha256 = "16a1ac5n7k7sx15cnk03gw3fmslab3a7m74dc45rgpldgiff3577";
  };
  
  doCheck = false;

}
