{ stdenv
, fetchurl
, alsaLib
, curl
, libjack2
, ladspaPlugins 
, libglvnd
, dpkg
, patchelf
, freetype 
, runtimeShell
, xorg
}:

stdenv.mkDerivation rec {

  pname = "waveform";
  version = "11.0.26";

  src = fetchurl {
    url = "https://cdn.tracktion.com/file/tracktiondownload/waveform/11026/waveform_64bit_v${version}.deb";
    sha256 = "1fkza3a6m2nxn253j8wjm151hdkw50cms2swa6yk3jhi77zn1h8x";
  };

  nativeBuildInputs = [ dpkg patchelf ];

  propagatedBuildInputs = with xorg; [
    alsaLib curl libjack2 ladspaPlugins libglvnd freetype libX11 libXext
  ];

  unpackPhase = "dpkg-deb -x $src .";

  installPhase = ''
    mkdir -p $out/bin
    cp -r ./usr $out
    patchelf --set-interpreter $(cat $NIX_CC/nix-support/dynamic-linker) $out/usr/bin/Waveform11
    patchelf --set-rpath ${ stdenv.lib.makeLibraryPath (stdenv.lib.concat propagatedBuildInputs [stdenv.cc.cc]) } $out/usr/bin/Waveform11
    ln -sf $out/usr/bin/Waveform11 $out/bin/waveform
  '';

  dontStrip = true;
  dontFixup = true;
  dontBuild = true;
  dontPatchELF = true;
  
}

