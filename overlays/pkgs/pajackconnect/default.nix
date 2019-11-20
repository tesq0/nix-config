{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "pajackconnect";

  src = fetchFromGitHub {
    owner = "brummer10";
    repo = "pajackconnect";
    rev = "master";
    sha256 = "0x6qmwdm6ijqm2djp6mb85j09pr5iqnir15mb2xmf38nkp9xkjvi";
  };

  dontBuild = true;
  
  installPhase = ''
    
  mkdir -p $out/bin
  cp $src/pajackconnect $out/bin/
  chmod +x $out/bin/pajackconnect
  
  '';
  
}

