self: super:
{
  st = super.callPackage ./pkgs/st { };
  pgmodeler = super.libsForQt5.callPackage ./pkgs/pgmodeler { };
  # milton = super.callPackage ./pkgs/milton { };

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

  airtest = super.python39Packages.callPackage ./pkgs/python-modules/airtest {};

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
  mpv = super.wrapMpv (super.mpv-unwrapped.override { jackaudioSupport = true; }) {};
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


  # unityhub = super.callPackage ./pkgs/unityhub { };

  serenata = super.callPackage ./pkgs/php-packages/serenata { };

  razor-server = super.callPackage ./pkgs/razor-server { };

  openfortivpn = super.openfortivpn.overrideAttrs (old: rec {

    repo = "openfortivpn";
    version = "1.15.0";
    name = "${repo}-${version}";

    src = super.fetchFromGitHub {
      owner = "adrienverge";
      inherit repo;
      rev = "v${version}";
      sha256 = "1qsfgpxg553s8rc9cyrc4k96z0pislxsdxb9wyhp8fdprkak2mw2";
    };

  });

  openfortigui = super.libsForQt5.callPackage ./pkgs/openfortigui { };

  # dbeaver = super.dbeaver.overrideAttrs (old: rec {
  #   version = "21.1.0";
  #   src = super.fetchurl {
  #     url = "https://dbeaver.io/files/${version}/dbeaver-ce-${version}-linux.gtk.x86_64.tar.gz";
  #     sha256 = "sha256-CB3HuHgWtEPVYom0z0H849Ls1hkqywGQyyRWaa0PQDY=";
  #   };
  # });

  dbeaver = super.callPackage ./pkgs/dbeaver  {
    jdk = super.jdk11;
  };

  dbeaver-ee = super.callPackage ./pkgs/dbeaver-ee {
    jdk = super.jdk11;
  };

  jpdfbookmarks = super.callPackage ./pkgs/jpdfbookmarks {
    jdk = super.jdk11;
  };

  gtkextra = super.callPackage ./pkgs/gtkextra { };

  lepton-eda = super.callPackage ./pkgs/lepton-eda { };

  
  ardour = super.ardour.overrideAttrs (old: rec {
    version = "6.8";
    src = super.fetchgit {
      url = "git://git.ardour.org/ardour/ardour.git";
      rev = version;
      sha256 = "sha256-msTTNIFkCUf5TljtFbhEQMrxhYMz74K5fxnMvP5cp5s=";
    };
  });

  hydrogen = super.hydrogen.overrideAttrs (old: rec {
    version = "293cf9af271cc35dad48930be6f48f0c19d2c4d5";
    src = super.fetchFromGitHub {
      owner = "hydrogen-music";
      repo = "hydrogen";
      rev = version;
      sha256 = "sha256-RgYZRyRZXLL+/h1RXFUw38xc9vyJguI5NutwN08A7i0=";
    };
  });

  glad = super.callPackage ./pkgs/libs/glad {};
  
}
