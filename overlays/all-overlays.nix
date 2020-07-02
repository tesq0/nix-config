self: super:
{
  st = super.callPackage ./pkgs/st { };
  pgmodeler = super.libsForQt5.callPackage ./pkgs/pgmodeler { };
  milton = super.callPackage ./pkgs/milton { };

  # Python
  PyUserInput = super.python3Packages.callPackage ./pkgs/python-modules/PyUserInput { };
  setuptools-lint = super.python3Packages.callPackage ./pkgs/python-modules/setuptools-lint { };
  pynput = super.python3Packages.callPackage ./pkgs/python-modules/pynput { };

  SwSpotify = super.python3Packages.callPackage ./pkgs/python-modules/SwSpotify { };
  swaglyrics = super.python3Packages.callPackage ./pkgs/python-modules/swaglyrics { };

  # This version is bugged out
  # pykeepass = super.python3Packages.pykeepass.overrideAttrs (old: rec {
  #   pname = old.pname;
  #   version = "3.1.2";
  #   src = super.python3Packages.fetchPypi {
  #     inherit pname version;
  #     sha256 = "1715l6f17f9s1zvc3cgxwkf7dsmjfzyd67x6i3w9s19x4j20h2r8";
  #   };
  # });

  godot = super.godot.overrideAttrs (old: rec {
    pname = "godot";
    version = "3.2.2-RC-1";
    src = super.fetchFromGitHub {
      owner  = "godotengine";
      repo   = "godot";
      rev    = "5ee9553591ebb7926a238f2d5b5fb154db602b95";
      sha256 = "09vz3rkc1p5hm09fzgh88z8v0798bnn1gxhxwlblhhmrbsm2rw6f";
    };
    patches = [
      ./pkgs/godot/pkg_config_additions.patch
      ./pkgs/godot/dont_clobber_environment.patch
    ];
  });

  pykeepass-cache = super.python3Packages.callPackage ./pkgs/python-modules/pykeepass-cache { };
  passhole = super.python3Packages.callPackage ./pkgs/python-modules/passhole { };
  pajackconnect = super.callPackage ./pkgs/pajackconnect { };
  mpv = super.mpv.override { jackaudioSupport = true; };
  vlc = super.vlc.override { jackSupport = true; };

  ueberzug = super.python3Packages.callPackage ./pkgs/ueberzug {};

  udpt = super.callPackage ./pkgs/udpt {};

  xournalpp = super.xournalpp.overrideAttrs (old: rec {
    version = "5ded1c04971607eaa41690ea0425adccf90feddb";
    src = super.fetchFromGitHub {
      owner = "xournalpp";
      repo = old.pname;
      rev = version;
      sha256 = "1sfa31jk5sfhwbjrlbb6viyrn9inhng1hf629r5lcxfp7j6imsmn";
    };
  });

  waveform = super.callPackage ./pkgs/waveform {};

  droidcam = super.callPackage ./pkgs/droidcam { };

}
