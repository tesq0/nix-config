# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

let
  user = "vox_miki";
in
{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./environment.nix
    ./server-hosts.nix
    ../../base.nix
    ../../nix.nix
    ../../laptop.nix
    ../../ssh.nix
    ./dns.nix
    # ../vpn.nix
    # ../mount-drives.nix
    # ../syncthing.nix
    # ../music.nix
    # ../remote-desktop.nix
    ];
    
    # touchpad goes over i2c
    boot.blacklistedKernelModules = [ "psmouse" ];
    
    # Use the GRUB 2 boot loader.
    boot = {

      loader = {
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

      extraModprobeConfig = lib.mkDefault ''
        options snd slots=snd_usb_audio,snd-hda-intel
      '';
      
    };

    hardware.enableAllFirmware = true;

    boot.extraModulePackages = [ config.boot.kernelPackages.exfat-nofuse ];
    
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

    services.synergy.server = {
      enable = true;
      configFile = "/home/vox_miki/.synergy-server";
    };
      services.synergy.client = {
       enable = true;
        autoStart = true;
        screenName = "laptop";
        serverAddress = "192.168.50.165";
      };

      services.locate = {
        enable = true;
      };

      networking.hostName = "VOXMIKI"; # Define your hostname.

      networking.networkmanager.enable = true;
      networking.networkmanager.dhcp = "dhclient";
      networking.networkmanager.packages = with pkgs; [ networkmanager_strongswan networkmanager-fortisslvpn ];

      # VPN
      # services.strongswan = {
      #   enable = true;
      # };

      # MUNIN

      services.munin-cron = {
        enable = true;
        hosts = ''
          [${config.networking.hostName}]
          address localhost
        '';
      };

      services.munin-node.enable = true;
      
      services.nginx = {
        enable = true;
        virtualHosts = {
          "munin" = {
            root = "/var/www/munin";
            listen = [
              { addr = "*";
              port = 8888; }
            ];
            locations."/" = {
             index = "index.html";
            };
          };
        };
      };

      # networking.networkmanager.dns = "systemd-resolved";
      # services.resolved.enable = true;

      programs.nm-applet.enable = true;

      # services.teamviewer.enable = true;

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
      
      # Some programs need SUID wrappers, can be configured further or are
      # started in user sessions.
      # programs.mtr.enable = true;
      programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

      # List services that you want to enable:

      hardware.bluetooth.enable = true;
      hardware.bluetooth.powerOnBoot = true;
      hardware.bluetooth.settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
      services.blueman.enable = true;

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

      services.emacs = {
        enable = true;
        defaultEditor = true;
      };

      # Open ports in the firewall.
      # networking.firewall.enable = false;
      # 3000 - usually node webserver
      # 8080 - usually some nginx instance
      # 6001 - Websocket
      # 20, 21, 5000 - 5003 - ftp
      # 9000 xdebug
      networking.firewall.allowedTCPPorts = [ 3000 6001 8080 20 21 9003 9000 ];
      networking.firewall.allowedUDPPorts = [ 3000 6001 8080 20 21 9003 9000 ];
      networking.firewall.allowedTCPPortRanges = [ { from = 5000; to = 5003; } ];
      networking.firewall.allowedUDPPortRanges = [ { from = 5000; to = 5003; } ];

      networking.firewall.interfaces."docker0" = {
        allowedTCPPorts = [ 3306 9000 ];
        allowedUDPPorts = [ 3306 9000 ];
      };

      # Enable CUPS to print documents.
      services.printing.enable = true;
      # services.printing.drivers = [ ];
      services.avahi.enable = true;
      services.avahi.nssmdns = true;
      
      # hardware.sane.enable = true;
      # hardware.sane.extraBackends = [ pkgs.hplipWithPlugin ];

      # Enable sound.
      sound.enable = true;

      hardware.pulseaudio = {
        enable = true;
        support32Bit = true;
        extraModules = [ pkgs.pulseaudio-modules-bt ];
        package = pkgs.pulseaudioFull;
      };

      # hardware.pulseaudio.enable = false;

      # services.pipewire = {
      #   enable = true;
      #   pulse.enable = true;
        # media-session = {
        #   config.bluez-monitor = {
        #     properties = "{bluez5.codecs = [sbc]}";
        #   };
        # };

      # };

      # environment.etc."pipewire/media-session.d/bluez-monitor.conf".text = (builtins.readFile ./bluez-monitor.conf);

      # services.ofono = {
      #   enable = true;
      # };

      nixpkgs.config = {
        packageOverrides = pkgs: {
          vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
        };
        permittedInsecurePackages = [
          "libav-11.12"
        ];
      };

      hardware.opengl = {
        enable = true;
        driSupport = true;
      };

      # boot.initrd.kernelModules = [ "i965" ];

      # kernel.v4l2loopback.enable = true;
      
      hardware.opengl.extraPackages = with pkgs; [
         intel-compute-runtime
      ];

      # Enable the X11 windowing system.
      services.xserver.enable = true;
      services.xserver.displayManager.lightdm.enable = true;
      services.xserver.displayManager.lightdm.greeters.mini.enable = true;
      services.xserver.displayManager.lightdm.greeters.mini.user = "${user}";
      services.xserver.layout = "en_US,pl,it";
      # services.xserver.xkbOptions = "caps:swapescape, ctrl:swap_lalt_lctl_lwin";

      services.xserver.wacomOne = {
        enable = true;
        transformationMatrix = "0.375 0 0.375 0 1 0 0 0 1";
      };

      programs.qt5ct.enable = true;

      services.xserver.displayManager.sessionCommands = ''
        ${pkgs.xlibs.xset}/bin/xset r rate 300 30
        ${pkgs.numlockx}/bin/numlockx on
      '';

      services.xserver.videoDrivers = lib.mkDefault [ /*"displaylink"*/ "modesetting" ];

      services.xserver.monitorSection = ''
        Option "DPMS" "true"
      '';

      services.xserver.deviceSection = ''
        Option "TearFree" "true"
      '';

      services.xserver.extraConfig = ''
        Section "Monitor"
        Identifier  "eDP-1"
        Option			"PreferredMode" "1920x1080"
        Option			"Position" "0 0"
        Option      "Primary" "true"
        EndSection
        Section "Monitor"
        Identifier  "DP-1"
        Option			"PreferredMode" "1920x1080"
        Option			"RightOf" "eDP-1"
        EndSection
        Section "Monitor"
        Identifier  "HDMI-1"
        Option			"PreferredMode" "1280x1024"
        Option			"RightOf" "DP-1"
        EndSection
      '';

      services.xserver.exportConfiguration = true;

      services.xserver.inputClassSections = [ ''
        Identifier "Mouse"
        MatchIsPointer "yes"
        Option "ConstantDeceleration" "1.55"
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
        vSync           = true;
        backend         = "glx";
        shadowExclude = [ "class_g = 'slop'" "class_g = 'locate-pointer'"];
      };

      services.logind.extraConfig = ''
        HandlePowerKey=ignore
        IdleAction=lock
      '';

      # programs.xss-lock.enable = true;
      # programs.xss-lock.lockerCommand = "/home/vox_miki/.scripts/i3cmds/lock";

      virtualisation.docker.enable = true;
      virtualisation.docker.liveRestore = false;
      virtualisation.docker.enableOnBoot = false;

      virtualisation.virtualbox.host.enable = true;
      users.extraGroups.vboxusers.members = [ "${user}" ];

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
        vox_miki = { gid = 1000; }; 
        realtime = {};
      };

      users.users.vox_miki = {
        isNormalUser = true;
        home = "/home/${user}";

        # comment out for now...
        shell = pkgs.fish;
        extraGroups = [ "${user}" "wheel" "docker" "networkmanager" "adbusers" "plugdev" "wireshark" "audio" "video" "lp" "scanner" ];

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
