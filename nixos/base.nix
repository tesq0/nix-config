
{ config, pkgs, ... }:

let
  kill-high-mem-processes = ../cron/kill-high-mem-processes.pl;
in
{

  imports = (import ./modules/module-list.nix);

  config = {
    networking.extraHosts = builtins.readFile ../networking/bad-hosts;
    # Enable cron service
    services.cron = {
      enable = true;
      systemCronJobs = [
        "*/1 * * * *      mikus  ${pkgs.perl}/bin/perl -I$(${pkgs.findutils}/bin/find ${pkgs.perlPackages.ProcProcessTable} -name x86_64-linux-thread-multi) ${kill-high-mem-processes} >> /tmp/kill-high-mem-processes.log 2>&1"
      ];
    };
  };
  
}
