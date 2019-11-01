{ stdenv, fetchFromGitHub, pkgconfig, ncurses, xorg }:

stdenv.mkDerivation rec {
  name = "st";
  src = fetchFromGitHub {
    owner = "tesq0";
    repo = "st";
    rev = "master";
    sha256 = "04faa8sz3sgkmxck64qkm0gd4ad5xw7h17nrw9gw9hsfw4nbi2j7";
  };

  nativeBuildInputs = [ pkgconfig ncurses ];
  buildInputs = with xorg; [ libX11 libXft ];

  installPhase = ''
    TERMINFO=$out/share/terminfo make install PREFIX=$out
  '';
}
