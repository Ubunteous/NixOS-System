{ config, lib, ... }:

with lib;
let
  cfg = config.lab.dnsmasq;
  corecfg = config.lab;
in
{

  options.lab.dnsmasq = {
    enable = mkEnableOption "Enables support for DNSmasq";
  };

  config = mkIf (corecfg.enable && cfg.enable) {
    services.dnsmask = {
      enable = true;

      settings = {
        dhcp-leasefile = "/var/lib/dnsmasq/dnsmasq.leases";
        conf-file = optional cfg.resolveLocalQueries "/etc/dnsmasq-conf.conf";
        resolv-file = optional cfg.resolveLocalQueries "/etc/dnsmasq-resolv.conf";
        domain-needed = true;
        dhcp-range = [ "192.168.0.2,192.168.0.254" ];
      };

      # servers to query
      settings.server = [
        "8.8.8.8"
        "8.8.4.4"
      ];

      # package = pkgs.dnsmasq;
      # configFile = "/path/to/file";
      # resolveLocalQueries = true; # adds 127.0.0.1 to /etc/resolv.conf
      # alwaysKeepRunning = false;
    };
  };
}
