self: super: {
  st = with super; stdenv.mkDerivation rec {
    name = "st";
    src = fetchFromGitHub {
      owner = "tesq0";
      repo = "st";
      rev = "master";
      sha256 = "1xqqakq7j6hzmcacv7gldahczj2r2by8sip54mx1c3zndmxc0q1h";
    };

    nativeBuildInputs = [ pkgconfig ncurses ];
    buildInputs = with xorg; [ libX11 libXft ];

    installPhase = ''
      TERMINFO=$out/share/terminfo make install PREFIX=$out
    '';
  };
}
