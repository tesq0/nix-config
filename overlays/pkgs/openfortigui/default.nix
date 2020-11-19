{ stdenv, lib, fetchFromGitHub, cmake, qt5, makeWrapper, libsecret, qtkeychain, wrapQtAppsHook }:

stdenv.mkDerivation rec {

  name = "openfortigui";

  src = fetchFromGitHub {
    owner = "theinvisible";
    repo = "openfortigui";
    rev = "v0.9.2";
    sha256 = "0sfw0vij3py12z2q2ixknpivvqq32f2jwnigdm0n3kzavwqf588h";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ cmake wrapQtAppsHook makeWrapper ];
  buildInputs = [ qt5.qtbase qtkeychain libsecret ];

  installPhase = ''
    mkdir -p $out/bin
    mv ./bin $out/;
    wrapQtApp $out/bin/openfortigui 
  '';
  
}


