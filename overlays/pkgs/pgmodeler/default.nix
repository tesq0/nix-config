{ stdenv, pkgconfig, fetchFromGitHub, xorg, qmake, libxml2, postgresql, qtbase, qtsvg }:

stdenv.mkDerivation rec {
  name = "pgmodeler";
  src = fetchFromGitHub {
    owner = "pgmodeler";
    repo = "pgmodeler";
    rev = "master";
    sha256 = "15isnbli9jj327r6sj7498nmhgf1mzdyhc1ih120ibw4900aajiv";
  };

  nativeBuildInputs = [ pkgconfig qmake ];

  buildInputs = [ libxml2 postgresql qtbase qtsvg ];

  qmakeFlags = [
    "CONFIG+=release"
    "PREFIX=$(out)"
    "BINDIR=$(out)/bin"
    "PRIVATEBINDIR=$(out)/bin"
    "PRIVATELIBDIR=$(out)/lib"
    "pgmodeler.pro"
  ];

}

