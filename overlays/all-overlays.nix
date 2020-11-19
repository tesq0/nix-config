self: super:
{
  st = super.callPackage ./pkgs/st { };
  pgmodeler = super.libsForQt5.callPackage ./pkgs/pgmodeler { };
  milton = super.callPackage ./pkgs/milton { };

  # Python
  # locust = super.python3Packages.callPackage ./pkgs/python-modules/locust { };

  # python3Packages.flask = super.python3Packages.flask.overrideAttrs (oldAttrs: {
  #   version = "1.1.2";
  #   pname = "flask";
  #   src = super.python3Packages.fetchPypi {
  #     version = "1.1.2";
  #     pname = "Flask";
  #     sha256 = "0q3h295izcil7lswkzfnyg3k5gq4hpmqmpl6i7s5m1n9szi1myjf";
  #   };
  # });

  # flask-basicauth = super.python3Packages.callPackage ./pkgs/python-modules/flask-basicauth { };

  PyUserInput = super.python3Packages.callPackage ./pkgs/python-modules/PyUserInput { };
  
  setuptools-lint = super.python3Packages.callPackage ./pkgs/python-modules/setuptools-lint { };

  pynput = super.python3Packages.callPackage ./pkgs/python-modules/pynput { };

  swaglyrics = super.python3Packages.callPackage ./pkgs/python-modules/swaglyrics { };

  pykeepass-cache = super.python3Packages.callPackage ./pkgs/python-modules/pykeepass-cache { };
  
  SwSpotify = super.python3Packages.callPackage ./pkgs/python-applications/SwSpotify { };

  i3-swallow = super.python3Packages.callPackage ./pkgs/python-applications/i3-swallow { };

  i3-unity-fix = super.python3Packages.callPackage ./pkgs/python-applications/i3-unity-fix { };

  passhole = super.python3Packages.callPackage ./pkgs/python-applications/passhole { };

  ueberzug = super.python3Packages.callPackage ./pkgs/python-applications/ueberzug {};
  
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

  pajackconnect = super.callPackage ./pkgs/pajackconnect { };
  # mpv = super.mpv.override { jackSupport = true; };
  vlc = super.vlc.override { jackSupport = true; };

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

  droidcam = super.callPackage ./pkgs/droidcam {};

  v4l2loopback-droidcam = super.callPackage ./pkgs/droidcam/v4l2oopback.nix { kernel = super.linux; };


  obs-studio = super.obs-studio.overrideAttrs (old: rec {

    version = "c21fd6f275df65c8cd861428655268263e0f5a8a";

    src = super.fetchFromGitHub {
      owner = "obsproject";
      repo = "obs-studio";
      rev = version;
      sha256 = "0xydb0ryqnh3z7dc9r3zlas3y96amd5jgdjdicwzgzj9dz85kjnn";
      fetchSubmodules = true;
    };
    
  });

  acquisition = super.libsForQt5.callPackage ./pkgs/acquisition { };

  synthpod = super.callPackage ./pkgs/synthpod { }; 

  cadmus = super.libsForQt5.callPackage ./pkgs/cadmus { };


  unityhub = super.callPackage ./pkgs/unityhub { };

  serenata = super.callPackage ./pkgs/php-packages/serenata { };

  razor-server = super.callPackage ./pkgs/razor-server { };

  openfortivpn = super.openfortivpn.overrideAttrs (old: rec {

    repo = "openfortivpn";
    version = "1.12.0";
    name = "${repo}-${version}";

    src = super.fetchFromGitHub {
      owner = "adrienverge";
      inherit repo;
      rev = "v${version}";
      sha256 = "1ndyiw4c2s8m0xds4ff87rdpixhbma5v2g420w3gfc1p7alhqz66";
    };

  });

  openfortigui = super.libsForQt5.callPackage ./pkgs/openfortigui { };
  
}
