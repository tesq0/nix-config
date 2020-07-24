{ stdenv, fetchurl, appimageTools }:

let
  version = "0.0.2";
  desktopFile = stdenv.lib.readFile ./cadmus.desktop;
in appimageTools.wrapType2 rec {
  name = "cadmus";

  # extraPkgs = (pkgs: with pkgs; with xorg; [ ]);

  src = fetchurl {
    url = "https://github.com/josh-richardson/cadmus/releases/download/${version}/cadmus.AppImage";
    sha256 = "1hp21flzzbarif1xr9w9vp39fzc9r4vp2kv5dc0z4zrpv30vp8a6";
  };

  extraInstallCommands = "mkdir -p $out/share/applications && echo '${desktopFile}' > $out/share/applications/cadmus.desktop";

  meta = with stdenv.lib; {
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
