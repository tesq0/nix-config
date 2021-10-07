{ stdenv, fetchFromGitHub, cmake, pkg-config, python3 }:

stdenv.mkDerivation rec {

  pname = "glad";
  version = "1.0.34";

  src = fetchFromGitHub {
    repo = "glad";
    owner = "Dav1dde";
    rev = "a5ca31c88a4cc5847ea012629aff3690f261c7c4";
    sha256 = "sha256-SQqA4OcorRD2JN8B30ryJUCY0/ihBKrs4nLpyoldqaA=";
  };

  nativeBuildInputs = [cmake pkg-config python3];

}
