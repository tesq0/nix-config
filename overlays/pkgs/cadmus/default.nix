{ stdenv, lib, fetchurl, autoPatchelfHook, wrapQtAppsHook, makeWrapper, unzip, libGL, xorg, fontconfig, freetype, libgpgerror, gtk3, cairo, gdk-pixbuf, qt5, readline, libpulseaudio }:

let
  version = "0.0.1";
in stdenv.mkDerivation rec {

  name = "cadmus";
  
  src = fetchurl {
    url = "https://github.com/josh-richardson/cadmus/releases/download/${version}/cadmus.zip";
    sha256 = "0iibl2h17y2qph94jcb0gmgmfclcpyhbmml24myydrzz6glyhhr7";
  };

  sourceRoot = ".";

  nativeBuildInputs = [ autoPatchelfHook makeWrapper wrapQtAppsHook unzip ];
  propagatedBuildInputs = with xorg; [ libGL stdenv.cc.cc.lib libXi fontconfig freetype libgpgerror gtk3 cairo gdk-pixbuf qt5.qtbase readline ];
  
  installPhase = ''

  mkdir -p $out/bin

  cp -r * $out/

  wrapProgram $out/cadmus \
  --prefix LD_LIBRARY_PATH : ${libpulseaudio}/lib \
  --prefix QT_XKB_CONFIG_ROOT ":" "${xorg.xkeyboardconfig}/share/X11/xkb"
  
  ln -sf $out/cadmus $out/bin/cadmus

  '';

  dontStrip = true;
  
  meta = with lib; {
    homepage = "https://github.com/josh-richardson/cadmus";
    description = "Remove background noise from audio in real-time";
    longDescription = ''
      Cadmus is a graphical application which allows you to remove background noise from audio in real-time in any communication app. Cadmus adds a notification icon to your shell which allows you to easily select a microphone as a source, and subsequently creates a PulseAudio output which removes all recorded background noise (typing, ambient noise, etc).
    '';
    license = licenses.gpl3;
    platforms = [ "x86_64-linux" ];
    maintainers = with maintainers; [ tesq0 ];
  };
}
