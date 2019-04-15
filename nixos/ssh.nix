{ config, pkgs, ... }:

{
    # Enable the OpenSSH daemon.
    services.openssh.enable = true;
    services.openssh.ports = [ 1337 ];
    # services.openssh.forwardX11 = true;
    # services.openssh.extraConfig = ''
    #   AllowTcpForwarding yes
    #   X11UseLocalhost yes
    #   X11DisplayOffset 10
    # '';

}
