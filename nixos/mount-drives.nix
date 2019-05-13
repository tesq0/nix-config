{ config, pkgs, ... }:

{
	  # Mount drives

		fileSystems."/media/WINDOWS_DATA" = {
      device = "/dev/sda2";
      fsType = "ntfs";
      options = [ "rw" "data=ordered" "relatime" ];
    };
    
}
