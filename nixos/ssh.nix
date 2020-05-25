{ config, pkgs, ... }:

{
    # Enable the OpenSSH daemon.
    services.openssh.enable = true;
    services.openssh.ports = [ 1337 ];
    services.openssh.extraConfig = ''
      PasswordAuthentication no
    '';

}
