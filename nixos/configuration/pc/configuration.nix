# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./environment.nix
    ./hosts.nix
    ../../base.nix
    ../../nix.nix
    ./mount-drives.nix
    ../../ssh.nix
    ../../vpn.nix
    # ./remote-desktop.nix
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

    # boot.extraModulePackages = [ config.boot.kernelPackages.exfat-nofuse ];

    kernel.v4l2loopback.enable = true;

    # Apple keyboard
    boot.extraModprobeConfig = ''
      options hid_apple swap_opt_cmd=1
      options hid_apple fnmode=2
    '';

    services.vsftpd = {
      enable = true;
      anonymousUser = true;
      anonymousUserNoPassword = true;
      rsaCertFile = "/var/vsftpd/vsftpd.pem";
      extraConfig = ''
        pasv_min_port=5000
        pasv_max_port=5003
      '';
    };
    
    networking.hostName = "mikusNix"; # Define your hostname.
    networking.networkmanager.enable = true;
    
    programs.nm-applet.enable = true;

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    console.font = "Lat2-Terminus16";
    console.useXkbConfig = true;
    
    #Select internationalisation properties.
    i18n = {
      supportedLocales = [ "pl_PL.UTF-8/UTF-8" "en_US.UTF-8/UTF-8"];
      defaultLocale = "en_US.UTF-8";
    };

    # Set your time zone.
    time.timeZone = "Europe/Amsterdam";

    nixpkgs.config = {
      allowUnfree = true;
      # firefox.enableAdobeFlash = true;
      wine.build = "wineWow";
      permittedInsecurePackages = [
        "libav-11.12"
      ];
    };

    programs.chromium.enable = false;
    
    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

    # List services that you want to enable:

    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    services.blueman.enable = true;
    
    services.synergy.server.enable = true;
    services.synergy.server.screenName = "mikus";
    services.synergy.server.configFile = "/home/mikus/.synergy.conf";

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

    # Open ports in the firewall.
    # networking.firewall.enable = false;
    networking.firewall.allowedTCPPorts = [ 20 21 631 3000 8080 8000 24800 9000 ]; 
    networking.firewall.allowedUDPPorts = [ 20 21 631 3000 8080 8000 24800 9000 ]; 
    networking.firewall.allowedTCPPortRanges = [ { from = 19000; to = 19003; } { from = 5000; to = 5003; } ];
    networking.firewall.allowedUDPPortRanges = [ { from = 19000; to = 19003; } { from = 5000; to = 5003; } ];
    
    # Enable CUPS to print documents.
    services.printing.enable = true;
    services.printing.drivers = [ pkgs.brgenml1lpr pkgs.cnijfilter2 ];
    services.avahi.enable = true;
    services.avahi.nssmdns = true;

    hardware.sane.enable = true;
    hardware.sane.extraBackends = [ pkgs.cnijfilter2 ];
    
    # Enable sound.
    sound.enable = true;
    dj.enable = true;

    hardware.opengl.enable = true;
    hardware.opengl.driSupport = true;
    hardware.opengl.driSupport32Bit = true;

    # Enable the X11 windowing system.
    services.xserver.enable = true;
    services.xserver.displayManager.lightdm.enable = true;
    services.xserver.displayManager.lightdm.greeters.mini.enable = true;
    services.xserver.displayManager.lightdm.greeters.mini.user = "mikus";
    services.xserver.layout = "pl,en_US";

    services.xserver.windowManager.i3.enable = true;
    services.xserver.displayManager.defaultSession = "none+i3";
    programs.qt5ct.enable = true;

    programs.x2goserver = {
      enable = true;
      superenicer.enable = true;
    };

    services.xserver.desktopManager = {
      xterm.enable = false;
    };

    services.xserver.wacomOne = {

      enable = true; 
      transformationMatrix = "0.6 0 0 0 1 0 0 0 1";
      
    };

    services.xserver.displayManager.sessionCommands = ''
      nvidia-settings --load-config-only --config /home/mikus/.nvidia-settings-rc
    '';

    services.xserver.videoDrivers = [ "nv" "nvidia" "vesa" ];
    services.xserver.xrandrHeads = [ { output = "HDMI-0"; primary = true; } ];
    services.xserver.exportConfiguration = true;
    services.xserver.screenSection = ''
      Option "metamodes" "HDMI-0: nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
    '';

    services.xserver.deviceSection = ''
      Option "HardDPMS" "true"    
      Option "TripleBuffer" "false"    
    '';
    
    services.xserver.inputClassSections = [ ''
      Identifier "Mouse"
      MatchIsPointer "yes"
      Option "ConstantDeceleration" "1.55"
    ''
    ];

    # Make auto mounting work.
    # security.wrappers = {
    #   udevil = {
    #     source = "${pkgs.udevil}/bin/udevil"; 
    #     owner = "root";
    #   };
    # };

    # automatic mounting service. Included in udevil package
    # services.devmon = {
    #   enable = true; 
    # };

    services.compton = {
      enable          = true;
      fade            = true;
      shadow          = true;
      fadeDelta       = 3;
      shadowExclude = [ "class_g = 'slop'" "class_g = 'locate-pointer'" "name = 'cpt_frame_window'"];
    };

		services.logind.extraConfig = ''
      HandlePowerKey=ignore
      IdleAction=lock
    '';

    programs.xss-lock.enable = true;
    programs.xss-lock.lockerCommand = "/home/mikus/.scripts/i3cmds/lock";
    
    virtualisation.docker.enable = true;
    virtualisation.docker.enableOnBoot = false;
    virtualisation.virtualbox.host.enable = true;
    
    users.extraGroups.vboxusers.members = [ "mikus" ];
    # virtualisation.docker.extraOptions = "--userns-remap=mikus:mikus"; # extra safety docker
    virtualisation.docker.enableNvidia = true;


    # virtualisation.anbox.enable = true;
    

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

    # If your settings aren't being saved for some applications (gtk3 applications, firefox)
    #, like the size of file selection windows, or the size of the save dialog, you will need to enable dconf.
    programs.dconf.enable = true;
    services.dbus.packages = [ pkgs.gnome3.dconf ];

    # This value determines the NixOS release with which your system is to be
    # compatible, in order to avoid breaking some software such as database
    # servers. You should change this only after NixOS release notes say you
    # should.
    system.stateVersion = "20.09"; # Did you read the comment?

}
