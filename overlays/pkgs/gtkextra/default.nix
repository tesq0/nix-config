
{ stdenv,
lib,
fetchurl,
pkg-config,
gobject-introspection,
file,
autoreconfHook,
gtk2,
glib,
cairo,
atk,
pango,
libtiff,
libpng,
libjpeg
}:

let
  minorVersion = "3.3";
  revision = "4";
  version = "${minorVersion}.${revision}";
in
stdenv.mkDerivation rec {

  pname = "gtkextra";
  
  inherit version;

  src = fetchurl {
    url = "mirror://sourceforge/project/gtkextra/${minorVersion}/${pname}-${version}.tar.gz";
    sha256 = "1mpihbyzhv3ymfim93l9xnxmzhwyqdba5xb4rdn5vggdg25766v5";
  };

  preConfigure = ''
    sed -i -e 's;/usr/bin/file;${file}/bin/file;g' ./configure
  '';

  nativeBuildInputs = [ autoreconfHook gobject-introspection pkg-config ];

  buildInputs = [ gtk2 glib cairo atk pango libtiff libpng libjpeg ];

    meta = with lib; {
    homepage = "http://gtkextra.sourceforge.net/";
    description = "GtkExtra is a useful set of widgets for creating GUI's for GTK+.";
    license = licenses.lgpl2;
    platforms = platforms.linux;
    maintainers = with maintainers; [ tesq0 ];
  };
  
}




