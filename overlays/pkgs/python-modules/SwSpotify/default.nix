{ lib, buildPythonPackage, fetchPypi, flask-cors, requests, beautifulsoup4, dbus-python  }:

buildPythonPackage rec {

  pname = "SwSpotify";
  version = "1.1.2";

  propagatedBuildInputs = [ flask-cors requests beautifulsoup4 dbus-python ];

  src = fetchPypi {
    inherit pname version;
    sha256 = "1508bjqjxym2dd6s7ln0wm599cd0102z4bk2nv03ayvnh2cd88nn";
  };
  
  doCheck = false;

}
