{ lib
, stdenv
, fetchurl
, makeDesktopItem
, makeWrapper
, fontconfig
, freetype
, glib
, gtk3
, jdk
, libX11
, libXrender
, libXtst
, alsaLib
, zlib
, autoPatchelfHook
}:

stdenv.mkDerivation rec {
  pname = "dbeaver";
  version = "21.1.1";

  src = fetchurl {
    url = "https://dbeaver.io/files/${version}/dbeaver-ce-${version}-linux.gtk.x86_64.tar.gz";
    sha256 = "sha256-ablux7F16l4hAXBtTgVd/kul8ytQQE6NHBNL3OJ13PE=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = [
    fontconfig
    freetype
    glib
    gtk3
    jdk
    libX11
    libXrender
    libXtst
    zlib
    alsaLib
  ];

  desktopItems = [
    (makeDesktopItem {
      name = "dbeaver-ce";
      exec = "dbeaver";
      icon = "dbeaver";
      desktopName = "dbeaver-ce";
      comment = "SQL Integrated Development Environment";
      genericName = "SQL Integrated Development Environment";
      categories = "Development;";
    })
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp -r * $out/
    makeWrapper $out/dbeaver $out/bin/dbeaver \
        --prefix PATH : ${jdk}/bin \
        --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath ([ glib gtk3 libXtst ])} \
        --prefix XDG_DATA_DIRS : "$GSETTINGS_SCHEMAS_PATH"

      mkdir -p $out/share/pixmaps
      ln -s $out/icon.xpm $out/share/pixmaps/dbeaver.xpm
  '';

  meta = with lib; {
    homepage = "https://dbeaver.io/";
    description = "Dbeaver Community Edition";
    longDescription = ''
      Dbeaver Community Edition
    '';
    license = licenses.asl20;
    platforms = [ "x86_64-linux" ];
    maintainers = with maintainers; [ tesq0 ];
  };
}
