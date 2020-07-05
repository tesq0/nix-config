{ stdenv, fetchFromGitHub,

libjpeg_turbo, pkg-config,

alsaLib, speex, libav, glib, gtk3, gdk-pixbuf, atk, pango, cairo, freetype, fontconfig }:

stdenv.mkDerivation rec {

  name = "droidcam";
  
  src = fetchFromGitHub {
    owner = "aramg";
    repo = "droidcam";
    rev = "d887a3aeb3b158825878005c802136ff849c70ec";
    sha256 = "1qxfw6j21f686daqf72z0y16p7vlbg4vff58hv0i59pqk5qw3sfx";
  };
  
  nativeBuildInputs = [ pkg-config libjpeg_turbo.dev alsaLib speex libav glib gtk3 gdk-pixbuf atk pango cairo freetype fontconfig ];

  buildPhase = ''
    cd linux
    make JPEG="`pkg-config --libs --cflags libturbojpeg`" all
  '';
  
  installPhase = ''
    mkdir -p $out/bin
    cp droidcam* $out/bin
  '';
  
}

