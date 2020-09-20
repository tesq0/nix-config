{ stdenv, pkgs, php }:

stdenv.mkDerivation rec {
  version = "5.2.0";
  pname = "serenata";

  src = pkgs.fetchurl {
    url = "https://gitlab.com/Serenata/Serenata/uploads/a173bbfc7d3d7026a45bf7158533ded6/distribution-7.3.phar";
    sha256 = "04dv8j5dl5gbgrml929sn8w421xz3cr7w5dqcazj31mnix64pnaf";
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
