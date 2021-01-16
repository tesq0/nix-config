{ stdenv,
lib,
pkgconfig,
texinfo,
fetchurl,
autoreconfHook,
guile,
flex,
gtk2,
gtkextra,
gettext,
gawk,
# Recommended libs
shared-mime-info,
groff,
# Optional libs
libstroke
}:

let
  version = "1.9.13-20201211";
  shortVer = builtins.head (lib.splitString "-" version);
in
stdenv.mkDerivation rec {

  pname = "lepton-eda";

  inherit version;

  src = fetchurl {
    url = "https://github.com/lepton-eda/lepton-eda/releases/download/${version}/lepton-eda-${shortVer}.tar.gz";
    sha256 = "17z1r9mdc8b4q6k8x7xv8ixkbkzhrlnw4l53wn64srd72labf5zl";
  };

  nativeBuildInputs = [ pkgconfig texinfo autoreconfHook ];

  configureFlags = [
    "--disable-update-xdg-database"
  ];

  CFLAGS = [
    "-DSCM_DEBUG_TYPING_STRICTNESS=2"
  ];

  buildInputs = [ guile flex gtk2 gtkextra gettext gawk shared-mime-info groff libstroke ];
  
}

