{ lib
, stdenv
, fetchurl
, jdk
, makeWrapper
, autoPatchelfHook
}:

stdenv.mkDerivation rec {
  pname = "jpdfbookmarks";
  version = "2.5.2";

  src = fetchurl {
    url = "mirror://sourceforge/jpdfbookmarks/JPdfBookmarks-${version}/jpdfbookmarks-${version}.tar.gz";
    sha256 = "sha256-irUcIEFFkWMuSK04F+bJfpwCnbiq7/I9dMIZcYz+Gfk=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = [
    jdk
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp -r * $out/
    makeWrapper $out/jpdfbookmarks $out/bin/jpdfbookmarks \
        --prefix PATH : ${jdk}/bin
  '';

}
