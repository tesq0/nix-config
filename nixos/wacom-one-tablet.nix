{ config, pkgs, ... }:

{

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
  Option        "TransformationMatrix" "1 0 0 0 1 0 0 0 1" #"0.6 0 0 0 1 0 0 0 1"
  EndSection

'';

}
