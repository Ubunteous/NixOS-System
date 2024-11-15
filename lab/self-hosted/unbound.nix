{ config, lib, ... }:

with lib;
let
  cfg = config.lab.unbound;
  corecfg = config.lab;
in {

  options.lab.unbound = {
    enable = mkEnableOption "Enables support for Unbound";
  };

  config = mkIf (corecfg.enable && cfg.enable) {
    services.unbound = {
      enable = true;

      # # example for settings
      # settings = {
      #   server = { interface = [ "127.0.0.1" ]; };
      #   forward-zone = [
      #     {
      #       name = ".";
      #       forward-addr = "1.1.1.1@853#cloudflare-dns.com";
      #     }
      #     {
      #       name = "example.org.";
      #       forward-addr = [
      #         "1.1.1.1@853#cloudflare-dns.com"
      #         "1.0.0.1@853#cloudflare-dns.com"
      #       ];
      #     }
      #   ];
      #   remote-control.control-enable = true;
      # };

      # user = "unbound";
      # group = "unbound";
      # resolveLocalQueries = true;
      # enableRootTrustAnchor = true;
      # stateDir = "/var/lib/unbound";
      # package = pkgs.unbound-with-systemd;

      # localControlSocketPath = null; # "/run/unbound/unbound.ctl"
      # checkconf = "!services.unbound.settings ? include && !services.unbound.settings ? remote-control";
    };
  };
}
