{ stdenv, fetchFromGitHub, qmake, qt5, boost, wrapQtAppsHook }:

stdenv.mkDerivation rec {

  name = "acquisition";

  src = fetchFromGitHub {
    owner = "xyzz";
    repo = "acquisition";
    rev = "bea41211cbf1d9b40b400c3b9ceb15af0b28ccda";
    sha256 = "00pwlmscbcd598wykwyv4zyaniwzfpk09l71kw3fxrvvwm3w6s2m";
  };

  nativeBuildInputs = [ qmake boost wrapQtAppsHook ];

  propagatedBuildInputs = with qt5; [ qtbase qtwebengine ];

  installPhase = ''
    mkdir -p $out/bin
    cp acquisition $out/bin/
  '';
  
}

