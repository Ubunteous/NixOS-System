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

      # example for settings
      settings = {
        # When only using Unbound as DNS, make sure to replace 127.0.0.1 with your ip address
        # When using Unbound in combination with pi-hole or Adguard, leave 127.0.0.1, and point Adguard to 127.0.0.1:PORT
        server = {
          # interface = [ "127.0.0.1" ];
          interface = [ "127.0.0.8" ]; # to use with blocky

          port = 5335;
          access-control = [ "127.0.0.1 allow" ];

          do-ip4 = true;
          do-ip6 = false;

          cache-max-ttl = 60;
          cache-max-negative-ttl = 60;
          serve-original-ttl = true;

          # Based on recommended settings in https://docs.pi-hole.net/guides/dns/unbound/#configure-unbound
          harden-glue = true;
          harden-dnssec-stripped = true;
          use-caps-for-id = false;
          prefetch = true;
          edns-buffer-size = 1232;
          # logfile = "/var/log/unbound";

          # Custom settings
          hide-identity = true;
          hide-version = true;

          # send minimal amount of information to upstream servers to enhance privacy
          qname-minimisation = true;
        };

        forward-zone = [
          # {
          #   name = ".";
          #   forward-addr = "1.1.1.1@853#cloudflare-dns.com";
          # }
          {
            name = ".";
            forward-addr =
              [ "9.9.9.9#dns.quad9.net" "149.112.112.112#dns.quad9.net" ];
            forward-tls-upstream = true; # Protected DNS
          }
          {
            name = "example.org.";
            forward-addr = [
              "1.1.1.1@853#cloudflare-dns.com"
              "1.0.0.1@853#cloudflare-dns.com"
            ];
          }
          {
            name = "example.com.";
            forward-addr = [
              "1.1.1.1@853#cloudflare-dns.com"
              "1.0.0.1@853#cloudflare-dns.com"
            ];
          }
        ];

        remote-control.control-enable = true;
      };

      localControlSocketPath = null; # "/run/unbound/unbound.ctl"
      # checkconf = true;

      ############
      # DEFAULTS #
      ############

      user = "unbound";
      group = "unbound";
      resolveLocalQueries = true;
      enableRootTrustAnchor = true;
      stateDir = "/var/lib/unbound";

      # package = pkgs.unbound; # pkgs.unbound-with-systemd

    };
  };
}
