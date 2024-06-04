{ config, lib, ... }:

# see https://xeiaso.net/blog/prometheus-grafana-loki-nixos-2020-11-20/

with lib;
let
  cfg = config.lab.grafana;
  labcfg = config.lab;
in {
  options.lab.grafana = { enable = mkEnableOption "Enables support Grafana"; };

  config = mkIf (labcfg.enable && cfg.enable) {
    ###########
    # GRAFANA #
    ###########

    # go to http://localhost:3000/ and log with admin / admin
    services.grafana = {
      enable = true;

      settings.server = {
        protocol = "http";
        domain = "localhost";
        http_addr = "127.0.0.1";
        http_port = 3002; # default is 3000
      };

      dataDir = "/var/lib/grafana";

      # root_url = "https://your.domain/grafana/"; # Not needed if it is `https://your.domain/`
      # serve_from_sub_path = true;
    };
  };
}
