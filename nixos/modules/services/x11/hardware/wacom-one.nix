{ config, pkgs, lib, ... }:

with lib;

let

  cfg = config.services.xserver.wacomOne;

in

{

  options = {

    services.xserver.wacomOne = {

      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Whether to enable the Wacom One tablet.
        '';
      };

      transformationMatrix = mkOption {
        type = types.str;
        default = "1 0 0 0 1 0 0 0 1";
        description = ''
          Option "TransformationMatrix" "a b c d e f g h i"
          Specifies the 3x3 transformation matrix for absolute input devices. The input device will be bound to the area given in the matrix. In most configurations, "a" and "e" specify the width and height of the area the device is bound to, and "c" and "f" specify the x and y offset of the area. The value range is 0 to 1, where 1 represents the width or height of all root windows together, 0.5 represents half the area, etc. The values represent a 3x3 matrix, with the first, second and third group of three values representing the first, second and third row of the matrix, respectively. The identity matrix is "1 0 0 0 1 0 0 0 1".
        '';
      };

    };

  };
  
  config = mkIf cfg.enable {

    environment.systemPackages = [ pkgs.xf86_input_wacom ]; # provides xsetwacom

    services.xserver.modules = [ pkgs.xf86_input_wacom ];

    services.udev.packages = [ pkgs.xf86_input_wacom ];

    environment.etc."X11/xorg.conf.d/70-wacom.conf".text = ''

    Section "InputClass"
    Identifier "Wacom tablet class"
    MatchProduct "Wacom|WACOM|PTK-540WL|ISD-V4"
    MatchDevicePath "/dev/input/event*"
    MatchIsTablet "true"
    Driver "wacom"
    Option        "tilt"         "on"  # add this if your tablet supports tilt
    Option        "Threshold"    "5"   # the official linuxwacom howto advises this line
    Option        "TransformationMatrix" "${cfg.transformationMatrix}"
    EndSection

  '';
  
  
  };


}
