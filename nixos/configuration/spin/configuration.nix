# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./environment.nix
    ./sway.nix
    ../../base.nix
    ../../nix.nix
    ../../common/ssh.nix
    ];

    boot.loader.efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };

    services.logind.extraConfig = ''
      # don’t shutdown when power button is short-pressed
      HandlePowerKey=ignore
    '';

    boot.loader.grub = {
      enable = true;
      version = 2;
      device = "nodev";
      efiSupport = true;
      enableCryptodisk = true;  
    };

    boot.initrd.kernelModules = [ "i915" ];

    hardware.opengl.extraPackages = with pkgs; [
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      intel-media-driver
    ];

    boot.initrd.luks.devices = {
      root = {
        device = "/dev/disk/by-uuid/1793a79f-a296-4560-96f8-aa8799aedca6";
        preLVM = true;
      };
    };

    networking.hostName = "mikusNix"; # Define your hostname.
    networking.networkmanager.enable = true;
    
    # programs.nm-applet.enable = true;

    console.font = "Lat2-Terminus16";
    
    #Select internationalisation properties.
    i18n = {
      supportedLocales = [ "pl_PL.UTF-8/UTF-8" "en_US.UTF-8/UTF-8"];
      defaultLocale = "en_US.UTF-8";
    };

    # Set your time zone.
    time.timeZone = "Europe/Amsterdam";

    nixpkgs.config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "libav-11.12"
      ];
    };

    programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

    # List services that you want to enable:

    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    services.blueman.enable = true;

    location = {
      latitude = 53.4275432;
      longitude = 14.4744383;
    };

    services.redshift = {
      enable = true;
      temperature.day = 5500;
      temperature.night = 2700;
    };

    # Open ports in the firewall.
    # networking.firewall.enable = false;
    networking.firewall.allowedTCPPorts = [ 20 21 631 3000 8080 8000 24800 9000 ]; 
    networking.firewall.allowedUDPPorts = [ 20 21 631 3000 8080 8000 24800 9000 ]; 
    networking.firewall.allowedTCPPortRanges = [ { from = 19000; to = 19003; } { from = 5000; to = 5003; } ];
    networking.firewall.allowedUDPPortRanges = [ { from = 19000; to = 19003; } { from = 5000; to = 5003; } ];
    
    # Enable sound.
    sound.enable = true;
    dj.enable = true;

    hardware.opengl.enable = true;
    hardware.opengl.driSupport = true;
    hardware.opengl.driSupport32Bit = true;

    programs.qt5ct.enable = true;

    virtualisation.docker.enable = true;
    virtualisation.docker.enableOnBoot = false;
    virtualisation.virtualbox.host.enable = true;
    
    users.extraGroups.vboxusers.members = [ "mikus" ];
    # virtualisation.docker.extraOptions = "--userns-remap=mikus:mikus"; # extra safety docker

    programs.adb.enable = true;

    fonts.fonts = with pkgs; [
      nerdfonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      mplus-outline-fonts
      dina-font
      proggyfonts
      hack-font
      montserrat
    ];
    
    # Define a user account. Don't forget to set a password with ‘passwd’.

    users.groups = {
      mikus = { gid = 1000; }; 
      realtime = {};
    };

    users.users.mikus = {
      isNormalUser = true;
      home = "/home/mikus";

      # comment out for now...
      shell = pkgs.fish;
      extraGroups = [ "mikus" "wheel" "docker" "networkmanager" "adbusers" "plugdev" "wireshark" "audio" "realtime" "jackaudio" "transmission" "scanner" "lp" ];

      # For docker namespaces
      subUidRanges = [
        { startUid = 1000; count = 1; }
        { startUid = 100001; count = 65534; }
      ];

      subGidRanges = [
        { startGid = 1000; count = 1; }
        { startGid = 10001; count = 65534; }
      ];

    };

    programs.dconf.enable = true;
    services.dbus.packages = [ pkgs.gnome3.dconf ];

    system.stateVersion = "21.11";

}
