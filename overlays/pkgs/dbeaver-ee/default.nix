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
  pname = "dbeaver-ee";
  version = "21.1.0";

  src = fetchurl {
    url = "https://dbeaver.com/files/${version}/dbeaver-ee-${version}-linux.gtk.x86_64.tar.gz";
    sha256 = "sha256-sD2JWv4R3rIdSiwooElrDUf9pP4r0RVr4T6V9b8lqTk";
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
      name = "dbeaver-ee";
      exec = "dbeaver-ee";
      icon = "dbeaver-ee";
      desktopName = "dbeaver EE";
      comment = "SQL Integrated Development Environment";
      genericName = "SQL Integrated Development Environment";
      categories = "Development;";
    })
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp -r * $out/
    mv $out/dbeaver $out/dbeaver-ee
    makeWrapper $out/dbeaver-ee $out/bin/dbeaver-ee \
        --prefix PATH : ${jdk}/bin \
        --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath ([ glib gtk3 libXtst ])} \
        --prefix XDG_DATA_DIRS : "$GSETTINGS_SCHEMAS_PATH"

      mkdir -p $out/share/pixmaps
      ln -s $out/icon.xpm $out/share/pixmaps/dbeaver-ee.xpm
  '';

  meta = with lib; {
    homepage = "https://dbeaver.com/";
    description = "Dbeaver Enterprise Edition";
    longDescription = ''
      Dbeaver Enterprise Edition
    '';
    license = licenses.asl20;
    platforms = [ "x86_64-linux" ];
    maintainers = with maintainers; [ tesq0 ];
  };
}
