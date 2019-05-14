{ config, pkgs, ... }:

{

  environment.systemPackages = [ pkgs.xboxdrv ];

  boot.blacklistedKernelModules = [ "xpad" ];

  environment.etc."default/xboxdrv".text = ''
    [xboxdrv]
    silent = true
    device-name = "Xbox 360 Wireless Receiver"
    mimic-xpad = true
    deadzone = 4000

    [xboxdrv-daemon]
    dbus = disabled
  '';

  systemd.services.xboxdrv = {
    description = "Xbox/Xbox360 USB Gamepad Driver for Userspace";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = ''
        ${pkgs.xboxdrv}/bin/xboxdrv --daemon --config /etc/default/xboxdrv
      '';
      RestartSec = 3;
      Restart = "always";
    };
  };
  

}