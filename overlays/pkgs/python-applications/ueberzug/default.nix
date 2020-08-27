{ lib, buildPythonApplication, fetchPypi, xorg, xlib, psutil, pillow, attrs, docopt }:

buildPythonApplication rec {

  pname = "ueberzug";
  version = "18.1.5";
  
  src =fetchPypi {
    inherit pname version;
    sha256 = "1rj864sdn1975v59i8j3cfa9hni1hacq0z2b8m7wib0da9apygby";
  };

  propagatedBuildInputs = with xorg; [ libX11 libXext psutil pillow xlib attrs docopt ];

  doCheck = false;

  meta = with lib; {
    homepage = https://github.com/seebye/ueberzug;
    description = "ueberzug is an alternative for w3mimgdisplay";
    license = licenses.gpl3;
  };

}
