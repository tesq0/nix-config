{ stdenv, pkgs, php }:

stdenv.mkDerivation rec {
  version = "5.4.0";
  pname = "serenata";

  src = pkgs.fetchurl {
    url = "https://gitlab.com/Serenata/Serenata/-/jobs/735379567/artifacts/raw/bin/distribution.phar";
    sha256 = "1k8sf3f3lppnfsij7y3kqkfww1lhyafqf01vg3gc7mrsi05almq8";
  };

  phases = [ "installPhase" ];
  buildInputs = [ pkgs.makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin
    install -D $src $out/libexec/serenata/serenata.phar
    makeWrapper ${php}/bin/php $out/bin/serenata \
    --add-flags "$out/libexec/serenata/serenata.phar"
  '';

  meta = with pkgs.lib; {
    description = "Gratis, libre and open source server providing code assistance for PHP";
    license = licenses.gpl3;
    homepage = "https://serenata.gitlab.io/";
    maintainers = with maintainers; [ tesq0 ];
  };
}
