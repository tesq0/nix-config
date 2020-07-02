{ stdenv, fetchurl }:

let
  arch = "64";
in
stdenv.mkDerivation rec {

  name = "droidcam";
  
  src = fetchurl {
    url = "https://www.dev47apps.com/files/linux/droidcam_081219_${arch}bit.tar.bz2";
    sha256 = "0xd765cc6g4vha0g1wfzhdnjlkhdxmy0w5ln5j4vqbz48wz2a5ps";
  };

  unpackPhase = ''
    tar xjf $src
  '';

  installPhase = ''
    mkdir -p $out
    cp -r droidcam-${arch}bit/* $out
    cd $out
    patchShebangs . 
    ./install
  '';
  
}

