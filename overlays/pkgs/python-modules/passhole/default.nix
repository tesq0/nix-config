{ lib, buildPythonApplication, fetchPypi, pykeepass, colorama, pygpgme, PyUserInput, xlib, pykeepass-cache, pynput, rpyc, python-daemon }:

buildPythonApplication rec {

  pname = "passhole";
  version = "1.9.post2";

  src = /home/mikus/temp/passhole;
  #   fetchPypi {
  #   inherit pname version;
  #   sha256 = "16prj430h67w31rfzn6vk0l2h95ymzjfdhh47jq6y7h7vcr7q1hm";
  # };

  propagatedBuildInputs = [ pykeepass colorama pygpgme PyUserInput xlib pykeepass-cache pynput rpyc python-daemon ];

  doCheck = false;

  meta = with lib; {
    homepage = https://github.com/Evidlo/passhole;
    description = "KeePass CLI + dmenu interface ";
    license = licenses.gpl3;
  };

}
