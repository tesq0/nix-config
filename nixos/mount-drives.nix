{ config, pkgs, ... }:

{

  boot.supportedFilesystems = [ "ntfs" ];
	  # Mount drives

		fileSystems."/media/STORAGE" = {
      device = "/dev/sda2";
      fsType = "ntfs";
      options = [ "rw" "data=ordered" "relatime" ];
    };

		fileSystems."/media/SYN01" = {
      device = "//10.42.0.8/homes/mikus";
      fsType = "cifs";
      options = let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in ["${automount_opts},credentials=/root/nixos/smb-secrets,uid=1000,gid=100,vers=1.0"];    };
    
}
