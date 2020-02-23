{ lib, buildPythonPackage, fetchPypi, xlib }:

buildPythonPackage rec {

  pname = "PyUserInput";
  version = "0.1.11";

  propagatedBuildInputs = [ xlib ];

  src = fetchPypi {
    inherit pname version;
    sha256 = "0azvlzfczrxhpxi15r37cbqkbbn5ip5y28bj5kmywh7pdk85wsq0";
  };
  
  doCheck = false;

}
