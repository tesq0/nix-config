self: super:
{
  st = super.callPackage ./pkgs/st { };
  pgmodeler = super.libsForQt5.callPackage ./pkgs/pgmodeler { };
  milton = super.callPackage ./pkgs/milton {
    gtk2 = super.gtk2-x11;
  };
  pajackconnect = super.callPackage ./pkgs/pajackconnect { };
}
