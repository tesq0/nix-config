{ stdenv, pkgconfig, fetchFromGitHub, cmake, libGL, x11, gtk2, glib }:

stdenv.mkDerivation rec {

  name = "milton";

  src = /home/mikus/Documents/Projects/milton;

  # src = fetchFromGitHub {
  #   owner = "tesq0";
  #   repo = "milton";
  #   rev = "ff723c6c60bfcdfd59d06f867e7f8aed9b95df6a";
  #   sha256 = "1xm6j7bwkr2l2ffn7hqja5nj8inc3b82x51c7xk53c00zlxggk04";
  # };

  nativeBuildInputs = [ pkgconfig cmake ];

  cmakeFlags = [
    "-DGTK2_DEBUG=1"
    "-DGTK2_GDKCONFIG_INCLUDE_DIR=${gtk2}/lib/gtk-2.0/include"
    "-DGTK2_GLIBCONFIG_INCLUDE_DIR=${glib}/lib/glib-2.0/include"
  ];

  buildInputs = [
    libGL
    gtk2
    x11
  ];
  
}

