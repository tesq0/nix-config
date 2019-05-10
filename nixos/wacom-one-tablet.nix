{ config, pkgs, ... }:

{

  environment.systemPackages = [ pkgs.xf86_input_wacom ]; # provides xsetwacom

  services.xserver.modules = [ pkgs.xf86_input_wacom ];

  services.udev.packages = [ pkgs.xf86_input_wacom ];

  environment.etc."X11/xorg.conf.d/70-wacom.conf".text = ''

  Section "InputDevice"
  Driver        "wacom"
  Identifier    "stylus"
  Option        "Device"       "/dev/input/wacom"   # or the corresponding event?? for a static setup
  Option        "Type"         "stylus"
  Option        "USB"          "on"                 # USB ONLY
  Option        "Mode"         "Relative"           # other option: "Absolute"
  Option        "Vendor"       "WACOM"
  Option        "tilt"         "on"  # add this if your tablet supports tilt
  Option        "Threshold"    "5"   # the official linuxwacom howto advises this line
  EndSection

'';

}
