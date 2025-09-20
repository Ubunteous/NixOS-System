{ config, lib, ... }:

with lib;
let
  cfg = config.lab.blocky;
  labcfg = config.lab;
in {

  options.lab.blocky = {
    enable = mkEnableOption "Enables support for blocky DNS";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    # Ad blocking and caching DNS server
    services.blocky = {
      enable = true;
      settings = {
        # ports.dns = "53"; # defaults to 53
        connectIPVersion = "v4"; # Limiting current implementation to IPv4

        # Cloudflare's DNS. change to 127.0.0.1 or 8 for unbound (see server.interface in its config)
        upstreams.groups.default = if config.lab.unbound.enable then [
          "1.1.1.1"
          "1.0.0.1"
        ] else
          [ "127.0.0.8" ];

        blocking = {
          # Due to Blocky using itself as resolver it needs to startup without loading block lists
          # Added a delay for block list downloads so that Unbound has time to start
          loading = if config.lag.blocky.enable then {
            downloads = {
              attempts = 8;
              cooldown = "2s";
            };
            strategy = "fast";
            concurrency = 1;
          } else {
            downloads = {
              attempts = 5;
              cooldown = "10s";
            };
            strategy = "failOnError";
            concurrency = 16;
          };

          denylists = {
            # Block lists taken from https://github.com/hagezi/dns-blocklists
            "pro" = [
              "https://codeberg.org/hagezi/mirror2/raw/branch/main/dns-blocklists/wildcard/pro.txt"
            ];
            "tif" = [
              "https://codeberg.org/hagezi/mirror2/raw/branch/main/dns-blocklists/wildcard/tif.txt"
            ];
          };
          clientGroupsBlock.default = [ "pro" "tif" ];
        };

        caching = {
          prefetching = true;
          minTime = "1m";
        };
      };
    };
  };
}
