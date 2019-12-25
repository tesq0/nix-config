self: super:
{
  st = super.callPackage ./pkgs/st { };
  pgmodeler = super.libsForQt5.callPackage ./pkgs/pgmodeler { };
  milton = super.callPackage ./pkgs/milton { };

  # Python
  PyUserInput = super.python3Packages.callPackage ./pkgs/python-modules/PyUserInput { };
  setuptools-lint = super.python3Packages.callPackage ./pkgs/python-modules/setuptools-lint { };
  pynput = super.python3Packages.callPackage ./pkgs/python-modules/pynput { };

  # This version is bugged out
  # pykeepass = super.python3Packages.pykeepass.overrideAttrs (old: rec {
  #   pname = old.pname;
  #   version = "3.1.2";
  #   src = super.python3Packages.fetchPypi {
  #     inherit pname version;
  #     sha256 = "1715l6f17f9s1zvc3cgxwkf7dsmjfzyd67x6i3w9s19x4j20h2r8";
  #   };
  # });

  pykeepass-cache = super.python3Packages.callPackage ./pkgs/python-modules/pykeepass-cache { };
  passhole = super.python3Packages.callPackage ./pkgs/python-modules/passhole { };

}
