# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./environment.nix
    ./dns.nix
    ../../base.nix
    ../../nix.nix
    ../../laptop.nix
    ../../ssh.nix
    # ../vpn.nix
    # ../mount-drives.nix
    # ../syncthing.nix
    # ../music.nix
    # ../remote-desktop.nix
    ];

    # Use the GRUB 2 boot loader.
    boot.loader = {
      efi = {
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        version = 2;
        efiSupport = true;
        efiInstallAsRemovable = true;
        device = "nodev";
      };
    };

    services.vsftpd = {
      enable = true;
      anonymousUser = true;
      anonymousUserNoPassword = true;
      # rsaCertFile = "/var/vsftpd/vsftpd.pem";
      extraConfig = ''
        pasv_min_port=5000
        pasv_max_port=5003
      '';
    };

    services.synergy.client = {
      enable = true;
      autoStart = true;
      screenName = "laptop";
      serverAddress = "synergy-server.local";
    };

    services.locate = {
      enable = true;
    };

    networking.hostName = "mikusNixLaptop"; # Define your hostname.
    networking.networkmanager.enable = true;

    programs.nm-applet.enable = true;

    #Select internationalisation properties.
    i18n = {
      supportedLocales = [ "pl_PL.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" "it_IT.UTF-8/UTF-8"];
      defaultLocale = "en_US.UTF-8";
    };

    console.font = "Lat2-Terminus16";
    console.useXkbConfig = true;

    # Set your time zone.
    time.timeZone = "Europe/Amsterdam";

    nixpkgs.config = {
      allowUnfree = true;
      # firefox.enableAdobeFlash = true;
      # wine.build = "wineWow";
    };

    programs.chromium.enable = true;

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

    # List services that you want to enable:

    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;

    # for adaptive screen blue light

    location = {
      latitude = 53.4275432;
      longitude = 14.4744383;
    };

    services.redshift = {
      enable = true;
      temperature.day = 5500;
      temperature.night = 2700;
    };

    # emacs kappa
    services.emacs = {
      enable = true;
      defaultEditor = true;
    };

    # Open ports in the firewall.
    # networking.firewall.enable = false;
    # 8100 - Ionic
    # 8000 - Laravel
    # 6001 - Websocket
    # 20, 21, 5000 - 5003 - ftp
    networking.firewall.allowedTCPPorts = [ 3000 6001 8000 8100 20 21 ];
    networking.firewall.allowedUDPPorts = [ 3000 6001 8000 8100 20 21 ];
    networking.firewall.allowedTCPPortRanges = [ { from = 5000; to = 5003; } ];
    networking.firewall.allowedUDPPortRanges = [ { from = 5000; to = 5003; } ];

    # Enable CUPS to print documents.
    services.printing.enable = true;
    services.printing.drivers = [ pkgs.brgenml1lpr pkgs.hplip ];
    services.avahi.enable = true;
    services.avahi.nssmdns = true;

    services.xboxdrv.enable = true;

    hardware.sane.enable = true;
    hardware.sane.extraBackends = [ pkgs.hplipWithPlugin ];

    # Enable sound.
    sound.enable = true;
    hardware.pulseaudio.enable = true;
    hardware.pulseaudio.support32Bit = true;

    hardware.opengl.enable = true;
    hardware.opengl.driSupport = true;
    hardware.opengl.driSupport32Bit = true;

    # Enable the X11 windowing system.
    services.xserver.enable = true;
    services.xserver.displayManager.lightdm.enable = true;
    services.xserver.displayManager.lightdm.greeters.mini.enable = true;
    services.xserver.displayManager.lightdm.greeters.mini.user = "mikus";
    services.xserver.layout = "pl,en_US";

    # services.xserver.wacomOne.enable = true;

     nixpkgs.config.permittedInsecurePackages = [
         "libav-11.12"
     ];

    programs.qt5ct.enable = true;

    services.xserver.wacomOne = {
      enable = true; 
      transformationMatrix = "1 0 0 0 1 0 0 0 1";
    };

    services.xserver.displayManager.sessionCommands = ''
      ${pkgs.xlibs.xset}/bin/xset r rate 300 30
      ${pkgs.numlockx}/bin/numlockx on
    '';

    services.xserver.videoDrivers = [ "intel" ];

    services.xserver.monitorSection = ''
      Option "DPMS" "true"
    '';

    services.xserver.deviceSection = ''
      Option "TearFree" "true"
    '';

    services.xserver.extraConfig = ''
      Section "Monitor"
      Identifier  "HDMI1"
      Option			"PreferredMode" "1920x1080"
      Option			"Position" "0 0"
      Option      "Primary" "true"
      EndSection
      Section "Monitor"
      Identifier  "eDP1"
      Option			"PreferredMode" "1920x1080"
      Option			"Position" "1920 0"
      EndSection
    '';

    services.xserver.exportConfiguration = true;

    services.xserver.inputClassSections = [ ''
      Identifier "Mouse"
      MatchIsPointer "yes"
      Option "ConstantDeceleration" "1.5"
    ''
    ];

    # Make auto mounting work.
    security.wrappers = {
      udevil = {
        source = "${pkgs.udevil}/bin/udevil";
        owner = "root";
      };
    };

    # automatic mounting service. Included in udevil package
    services.devmon = {
      enable = true;
    };

    # Window manager
    services.xserver.windowManager.i3.enable = true;

    services.xserver.displayManager = {
      defaultSession = "none+i3";
    };

    services.compton = {
      enable          = true;
      fade            = true;
      shadow          = true;
      fadeDelta       = 3;
      shadowExclude = [ "class_g = 'slop'" "class_g = 'locate-pointer'"];
    };

    services.logind.extraConfig = ''
      HandlePowerKey=ignore
      IdleAction=lock
    '';

    # programs.xss-lock.enable = true;
    # programs.xss-lock.lockerCommand = "/home/mikus/.scripts/i3cmds/lock";

    virtualisation.docker.enable = true;
    virtualisation.docker.enableOnBoot = false;

    virtualisation.virtualbox.host.enable = true;
    users.extraGroups.vboxusers.members = [ "mikus" ];

    # virtualisation.anbox.enable = true;

    programs.adb.enable = true;

    fonts.fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
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
      extraGroups = [ "mikus" "wheel" "docker" "networkmanager" "adbusers" "plugdev" "wireshark" "audio" "video" "lp" "scanner" ];

    };

    # If your settings aren't being saved for some applications (gtk3 applications, firefox)
    #, like the size of file selection windows, or the size of the save dialog, you will need to enable dconf.
    programs.dconf.enable = true;
    services.dbus.packages = [ pkgs.gnome3.dconf ];

    # This value determines the NixOS release with which your system is to be
    # compatible, in order to avoid breaking some software such as database
    # servers. You should change this only after NixOS release notes say you
    # should.
    system.stateVersion = "19.03"; # Did you read the comment?

}
