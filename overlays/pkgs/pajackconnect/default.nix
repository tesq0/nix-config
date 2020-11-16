{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "pajackconnect";

  src = fetchFromGitHub {
    owner = "brummer10";
    repo = "pajackconnect";
    rev = "master";
    sha256 = "0y5sm1jd3a9nmbdjabvin6gxw9vfrzkgxfnskngw0912npz5cvz7";
  };

  dontBuild = true;
  
  installPhase = ''
    
  mkdir -p $out/bin
  cp $src/pajackconnect $out/bin/
  chmod +x $out/bin/pajackconnect
  
  '';
  
}

