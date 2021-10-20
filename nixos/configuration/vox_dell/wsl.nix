{ config, lib, pkgs, ... }:

let
  user = "vox-miki";
in
{
  imports =
    [ # Include the results of the hardware scan.
    ../../environment.nix 
    ./server-hosts.nix
    ../../base.nix
    ../../nix.nix
    ];

      # Set your time zone.
      time.timeZone = "Europe/Amsterdam";

      nixpkgs.config = {
        allowUnfree = true;
      };
      
      # Some programs need SUID wrappers, can be configured further or are
      # started in user sessions.
      # programs.mtr.enable = true;
      programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

      # List services that you want to enable:

      # for adaptive screen blue light

      location = {
        latitude = 53.4275432;
        longitude = 14.4744383;
      };

      virtualisation.docker.enable = true;
      virtualisation.docker.liveRestore = false;
      virtualisation.docker.enableOnBoot = false;

      programs.adb.enable = true;

      fonts.fonts = with pkgs; [
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        hack-font
        montserrat
      ];

      users.groups = {
        "${user}" = { gid = 1000; }; 
        realtime = {};
      };

      users.users.${user} = {
        isNormalUser = true;
        home = "/home/${user}";
        shell = pkgs.fish;
	hashedPassword = "$6$H6bRr1cth96vjU4$yswXs8cV7ooAGPB5sZN0Jo7sOv.kCxBl5qlzKv0L4ILF6EHVKu3Q.ei7d.gHyguq2B2guWASpg4mpeTFztWU4/";
        extraGroups = [ "${user}" "wheel" "docker" "adbusers" "plugdev" "wireshark" "audio" "video" ];
      };

}
