{ config, pkgs, ... }:

{

  # JACK

  /*
  services.jack = {
    jackd.enable = true;
    jackd.extraOptions = [ "-P10" "-p2048" "-dalsa" "-r48000" "-p128" "-n2" "-D" "-Chw:Device" "-Phw:PCH" ];

    # support ALSA only programs via ALSA JACK PCM plugin
    alsa.enable = false;


    # support ALSA only programs via loopback device (supports programs like Steam)
    loopback = {
      enable = true;
      # buffering parameters for dmix device to work with ALSA only semi-professional sound programs
      dmixConfig = ''
        period_size 2048
      '';
    };

  };
  */
  
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;

  systemd.services.resume-fix-pulseaudio = {
    description = "Fix PulseAudio after resume from suspend";
    after = [ "suspend.target" ];
    serviceConfig = {
      User = "mikus";
      Type = "oneshot";
      ExecStart = ''
        ${pkgs.pajackconnect}/bin/pajackconnect restart
      '';
    };
  };
  
  systemd.user.services.pulseaudio.environment = {
    JACK_PROMISCUOUS_SERVER = "jackaudio";
  };

  boot = {
    kernelModules = [ "snd-seq" "snd-rawmidi" ];
    kernel.sysctl = { "vm.swappiness" = 10; "fs.inotify.max_user_watches" = 524288; };
    kernelParams = [ "threadirq" ];
    
    postBootCommands = ''
      echo 2048 > /sys/class/rtc/rtc0/max_user_freq
      echo 2048 > /proc/sys/dev/hpet/max-user-freq
      setpci -v -d *:* latency_timer=b0
      setpci -v -s $00:1f.3 latency_timer=ff
    '';
    # The SOUND_CARD_PCI_ID can be obtained like so:
    # $ lspci ¦ grep -i audio
  };

  powerManagement.cpuFreqGovernor = "performance";

  fileSystems."/" = { options = ["noatime" "errors=remount-ro"]; };

  security.pam.loginLimits = [
    { domain = "@audio"; item = "memlock"; type = "-"; value = "unlimited"; }
    { domain = "@audio"; item = "rtprio"; type = "-"; value = "99"; }
    { domain = "@audio"; item = "nofile"; type = "soft"; value = "99999"; }
    { domain = "@audio"; item = "nofile"; type = "hard"; value = "99999"; }
  ];
}
