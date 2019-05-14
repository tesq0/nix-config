self: super: {
  st = with super; stdenv.mkDerivation rec {
    name = "st";
    src = fetchFromGitHub {
      owner = "tesq0";
      repo = "st";
      rev = "master";
      sha256 = "1dq3lgyv1mgn6k42a7bfwgwnz3whz6h69r1gvp4wpn5s6kbmzgvl";
    };

    nativeBuildInputs = [ pkgconfig ncurses ];
    buildInputs = with xorg; [ libX11 libXft ];

    installPhase = ''
      TERMINFO=$out/share/terminfo make install PREFIX=$out
    '';
  };
}
