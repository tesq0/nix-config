{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "pajackconnect";

  src = fetchFromGitHub {
    owner = "brummer10";
    repo = "pajackconnect";
    rev = "master";
    sha256 = "sha256-4ER5ZW3PfYcS9N32JcAECEZAKcpg3SdVjg39iDf0fv8=";
  };

  dontBuild = true;
  
  installPhase = ''
    
  mkdir -p $out/bin
  cp $src/pajackconnect $out/bin/
  chmod +x $out/bin/pajackconnect
  
  '';
  
}

