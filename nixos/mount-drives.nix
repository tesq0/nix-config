{ config, pkgs, ... }:

{

  boot.supportedFilesystems = [ "ntfs" ];
	  # Mount drives

		fileSystems."/media/STORAGE" = {
      device = "/dev/sda2";
      fsType = "ntfs";
      options = [ "rw" "data=ordered" "relatime" ];
    };
    
}
