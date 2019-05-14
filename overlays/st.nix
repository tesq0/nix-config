self: super: {
  st = with super; stdenv.mkDerivation rec {
    name = "st";
    src = fetchFromGitHub {
      owner = "LukeSmithxyz";
      repo = "st";
      rev = "master";
      sha256 = "1zw4f4skjys7c9yhhrhvfxjccjdj43vb631fapbvblafq9hxq3sg";
    };

    nativeBuildInputs = [ pkgconfig ncurses ];
    buildInputs = with xorg; [ libX11 libXft ];

    installPhase = ''
      TERMINFO=$out/share/terminfo make install PREFIX=$out
    '';
  };
}
