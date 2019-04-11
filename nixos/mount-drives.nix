{ config, pkgs, ... }:

{
	  # Mount drives

		fileSystems."/media/WINDOWS_DATA" = {
      device = "/dev/sda2";
      fsType = "ntfs";
      options = [ "rw" "data=ordered" "relatime" ];
    };

    fileSystems."/media/LINUX" = {
      device = "/dev/nvme0n1p6";
      fsType = "ext4";
    };

}
