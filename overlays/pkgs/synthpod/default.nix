{ stdenv,
fetchurl,
fetchFromGitLab,
meson,
ninja,
pkgconfig,
fontconfig,
alsaLib,
libjack2,
glew,
libGL,
lilv,
xorg,
xcbutilxrm,
lv2,
zita-alsa-pcmi
}:

stdenv.mkDerivation rec {

  name = "synthpod";
  version = "66dda05006eb2157b4b6ce1083557cc6c5485f91";

  src = fetchFromGitLab {
    owner = "OpenMusicKontrollers";
    repo = name;
    rev = version;
    sha256 = "0dzrcicrbqn7iw4dg2p5r2y03n9l0rrzs4kn931grccmy033i53m";
  };

  nativeBuildInputs = [ meson ninja fontconfig pkgconfig ];
  propagatedBuildInputs = with xorg; [ glew libGL libjack2 alsaLib libX11 libXext xcbutilxrm xcbutilwm lilv zita-alsa-pcmi lv2 ];


  buildPhase = ''

  ls -al 
  mkdir -p build

  meson build \
  --prefix="$out" \
  --libdir="lib"

  cd build
  meson configure -D b_lto=true
  meson configure -D use-alsa=true
  meson configure -D use-dummy=true
  meson configure -D use-jack=true
  meson configure -D use-x11=true

  '';

  installPhase = ''
    DESTDIR="$out" ninja install
  '';
  
}
