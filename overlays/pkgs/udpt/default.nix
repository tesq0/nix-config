{ stdenv, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage {
  pname = "udpt";
  version = "2019";
  
  src = fetchFromGitHub {
    owner = "naim94a";
    repo = "udpt";
    rev = "05ea65ca01d1914c57da363c873f7aa5712f29d7";
    sha256 = "1kfpg20igqfccyx4ffxhmsm79axryk21wabg1bdm0d3g0i4yf7h7";
  };
  
  cargoSha256 = "1snbxbj46fq8hyafgh0pf5gzs08gfbrrf8q381b3i6n67a8l53wy";
  
}
