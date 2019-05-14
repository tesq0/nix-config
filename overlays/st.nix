self: super: {
  st = with super; stdenv.mkDerivation {
    name = "st";
    src = fetchFromGitHub {
      owner = "LukeSmithxyz";
      repo = "st";
      rev = "master";
      sha256 = "123jr6w6gql5n35cwxdw4mq9g4gjlcc8ca73zkmym3pb0nwvkij7";
    };

    nativeBuildInputs = [ pkgconfig ncurses ];
    buildInputs = [ libX11 libXft ] ++ extraLibs;

    installPhase = ''
      TERMINFO=$out/share/terminfo make install PREFIX=$out
    '';
  };
}
