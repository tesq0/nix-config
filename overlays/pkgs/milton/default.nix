{ stdenv, pkgconfig, fetchFromGitHub, cmake }:

stdenv.mkDerivation rec {

  name = "milton";

  src = fetchFromGitHub {
    owner = "serge-rgb";
    repo = "milton";
    rev = "ff723c6c60bfcdfd59d06f867e7f8aed9b95df6a";
    sha256 = "1xm6j7bwkr2l2ffn7hqja5nj8inc3b82x51c7xk53c00zlxggk04";
  };

  nativeBuildInputs = [ pkgconfig cmake ];
  
}

