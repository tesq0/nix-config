# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  kill-high-mem-processes = ../cron/kill-high-mem-processes.pl;
in
{
  imports =
    [ # Include the results of the hardware scan.
    ./nix.nix
    ./hardware-configuration.nix
    ./mount-drives.nix
    ./environment.nix
    ./vpn.nix
    ./ssh.nix
    ./xboxdrv.nix
    ./wacom-one-tablet.nix
    # ./music.nix
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

    boot.extraModulePackages = [ config.boot.kernelPackages.exfat-nofuse ];

    # Apple keyboard
    boot.extraModprobeConfig = ''
      options hid_apple swap_opt_cmd=1
      options hid_apple fnmode=2
    '';

    networking.hostName = "mikusNix"; # Define your hostname.
    networking.networkmanager.enable = true;
    programs.nm-applet.enable = true;

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    #Select internationalisation properties.
    i18n = {
      consoleFont = "Lat2-Terminus16";
      consoleUseXkbConfig = true;
      supportedLocales = [ "pl_PL.UTF-8/UTF-8" "en_US.UTF-8/UTF-8"];
      defaultLocale = "en_US.UTF-8";
    };

    # Set your time zone.
    time.timeZone = "Europe/Amsterdam";

    nixpkgs.config = {
      allowUnfree = true;
      firefox.enableAdobeFlash = true;
      wine.build = "wineWow";
    };

    programs.chromium.enable = true;
    
    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

    # List services that you want to enable:

    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    
    services.synergy.server.enable = true;
    services.synergy.server.screenName = "mikus";
    services.synergy.server.configFile = "/home/mikus/.synergy.conf";

    # for adaptive screen blue light
    services.redshift = {
      enable = true;
      latitude = "53.4275432";
      longitude = "14.4744383";
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
    networking.firewall.allowedTCPPortRanges = [ { from = 19000; to = 19003; } ];
    networking.firewall.allowedUDPPortRanges = [ { from = 19000; to = 19003; } ];
    
    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable cron service
    services.cron = {
      enable = true;
      systemCronJobs = [
        "*/1 * * * *      mikus    ${pkgs.perl} ${kill-high-mem-processes} >> /tmp/kill-high-mem-processes.log"
      ];
    };

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
    services.xserver.layout = "en_US,pl";
    services.xserver.xkbOptions = "caps:swapescape, ctrl:swap_lalt_lctl_lwin";

    services.xserver.windowManager.i3.enable = true;
    services.xserver.windowManager.default = "i3";
    programs.qt5ct.enable = true;

    services.xserver.displayManager.sessionCommands = ''
      ${pkgs.xlibs.xset}/bin/xset r rate 300 30

      #Tab
      ${pkgs.xorg.xmodmap}/bin/xmodmap -e "keycode 23 = Super_L Super_L"
      ${pkgs.xorg.xmodmap}/bin/xmodmap -e "keycode 255 = Tab"

      #Enter to ctrl
      ${pkgs.xorg.xmodmap}/bin/xmodmap -e "remove Control = Control_R"
      ${pkgs.xorg.xmodmap}/bin/xmodmap -e "keycode 254 = Return"
      ${pkgs.xorg.xmodmap}/bin/xmodmap -e "keycode 36 = Control_R"
      ${pkgs.xorg.xmodmap}/bin/xmodmap -e "add Control = Control_R"

      #Backslash
      ${pkgs.xorg.xmodmap}/bin/xmodmap -e "keycode 51 = Super_R Super_R"
      ${pkgs.xorg.xmodmap}/bin/xmodmap -e "keycode 253 = backslash bar"
      
      ${pkgs.xcape}/bin/xcape -e "Super_L=Tab;Super_R=backslash;Control_R=Return"

      nvidia-settings --load-config-only --config /home/mikus/.nvidia-settings-rc
    '';

    services.xserver.videoDrivers = [ "nv" "nvidia" "vesa" ];
    services.xserver.xrandrHeads = [ { output = "DVI-D-0"; primary = false; } { output = "HDMI-0"; primary = true; } ];
    services.xserver.exportConfiguration = true;
    services.xserver.screenSection = ''
      Option "metamodes" "DVI-D-0: nvidia-auto-select +0+0 {ForceCompositionPipeline=On}, HDMI-0: nvidia-auto-select +0+0 {ForceCompositionPipeline=On}"
    '';

    services.xserver.deviceSection = ''
      Option "HardDPMS" "true"    
      Option "TripleBuffer" "false"    
    '';

    services.xserver.extraConfig = ''
      Section "Monitor"
      Identifier "HDMI-0"
      Option "PreferredMode" "1920x1080"
      Option "Position" "0 0"
      EndSection
      Section "Monitor"
      Identifier "DVI-D-0"
      Option "PreferedMode" "1920x1080"
      Option "Position" "0 0"
      Option "SameAs" "HDMI-0"
      EndSection
    '';

    services.xserver.inputClassSections = [ ''
      Identifier "Logitech USB Optical Mouse"
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
    services.xserver.desktopManager = {
      default = "none";
      xterm.enable = false;
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

    programs.xss-lock.enable = true;
    programs.xss-lock.lockerCommand = "/home/mikus/.scripts/i3cmds/lock";
    
    virtualisation.docker.enable = true;
    virtualisation.docker.enableOnBoot = false;
    virtualisation.virtualbox.host.enable = true;
    users.extraGroups.vboxusers.members = [ "mikus" ];
    # virtualisation.docker.extraOptions = "--userns-remap=mikus:mikus"; # extra safety docker
    # virtualisation.docker.enableNvidia = true;

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
    ];
    
    # Define a user account. Don't forget to set a password with ‘passwd’.

    users.groups = [
		  { gid = 1000; name = "mikus"; }
    ];

    users.users.mikus = {
      isNormalUser = true;
      home = "/home/mikus";

      # comment out for now...
      shell = pkgs.fish;
      extraGroups = [ "mikus" "wheel" "docker" "networkmanager" "adbusers" "plugdev" "wireshark" ];

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
    system.stateVersion = "19.03"; # Did you read the comment?

}
