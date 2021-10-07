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

    # dj = {
    #   enable = true;
    # };

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
        httpConfig = "index index.html;";
        virtualHosts = {
          "web" = {
            serverName = "web.this";
            root = "/var/www/vox_miki";
            listen = [
              {
                addr = "localhost";
                port = 8889;
              }
            ];
            locations."/" = {
              extraConfig = "autoindex = true;";
            };
          };
          "munin" = {
            serverName = "munin.this";
            root = "/var/www/munin";
            listen = [
              {
                addr = "localhost";
                port = 8889;
              }
            ];
            locations."/" = {
              index = "index.html";
            };
          };
        };
      };

      /*
      services.traefik = {
      enable = true;
      staticConfigFile = ./traefik.yml;
      group = "docker";
      dynamicConfigOptions = {
      http = {
      routers = {
      localNginx = {
      rule = "HostRegexp(`{subdomain:[a-z]+}.this`)";
      service = "localNginx";
      };
      };
      services = {
      localNginx = {
      loadBalancer = {
      servers = [{
      url = "http://localhost:8889";
      }];
      };
      };
      };
      };
      };
      };
      */

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
      networking.firewall.allowedTCPPorts = [ 3000 6001 8080 20 21 9003 9000 24800 ];
      networking.firewall.allowedUDPPorts = [ 3000 6001 8080 20 21 9003 9000 24800 ];
      networking.firewall.allowedTCPPortRanges = [ { from = 5000; to = 5003; } ];
      networking.firewall.allowedUDPPortRanges = [ { from = 5000; to = 5003; } ];

      networking.firewall.interfaces."docker0" = {
        allowedTCPPorts = [ 3306 9000 ];
        allowedUDPPorts = [ 3306 9000 ];
      };

      # Enable CUPS to print documents.
      services.printing.enable = true;
      services.printing.drivers = [ pkgs.brgenml1lpr pkgs.cnijfilter2 ];
      services.avahi.enable = true;
      services.avahi.nssmdns = true;
      
      hardware.sane.enable = true;
      hardware.sane.extraBackends = [ pkgs.cnijfilter2 ];

      # Enable sound.
      sound.enable = true;

      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        pulse.enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        media-session.config.bluez-monitor.rules = [
          {
            # Matches all cards
            matches = [ { "device.name" = "~bluez_card.*"; } ];
            actions = {
              "update-props" = {
                "bluez5.reconnect-profiles" = [ "hfp_hf" "hsp_hs" "a2dp_sink" ];
                # mSBC is not expected to work on all headset + adapter combinations.
                "bluez5.msbc-support" = true;
                # SBC-XQ is not expected to work on all headset + adapter combinations.
                "bluez5.sbc-xq-support" = true;
              };
            };
          }
          {
            matches = [
              # Matches all sources
              { "node.name" = "~bluez_input.*"; }
              # Matches all outputs
              { "node.name" = "~bluez_output.*"; }
            ];
            actions = {
              "node.pause-on-idle" = false;
            };
          }
        ];
      };

      hardware.bluetooth.enable = true;
      hardware.bluetooth.powerOnBoot = true;
      # hardware.bluetooth.hsphfpd.enable = true;
      services.blueman.enable = true;

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
      services.xserver.layout = "pl,en_US";

      services.xserver.wacomOne = {
        enable = true;
        transformationMatrix = "0.375 0 0.375 0 1 0 0 0 1";
      };

      programs.qt5ct.enable = true;

      services.xserver.displayManager.sessionCommands = ''
        ${pkgs.numlockx}/bin/numlockx on
      '';

      services.xserver.videoDrivers = lib.mkDefault [ "displaylink" "modesetting" ];

      services.xserver.deviceSection = ''
        Option "TearFree" "true"
      '';

      services.xserver.exportConfiguration = true;

      services.xserver.inputClassSections = [ ''
        Identifier "Mouse"
        MatchIsPointer "yes"
        Option "ConstantDeceleration" "1.55"
      ''
      ];

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

      system.stateVersion = "21.05";

}
