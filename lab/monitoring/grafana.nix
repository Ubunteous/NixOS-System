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

    networking.firewall.allowedTCPPorts = [ 3002 9090 ];

    # go to http://localhost:3000/ and log with admin / admin
    services.grafana = {
      enable = true;

      settings.server = {
        # protocol = "http"; # default
        # domain = "localhost"; # default
        http_addr = "0.0.0.0"; # defaults to
        http_port = 3002; # default is 3000
      };

      # dataDir = "/var/lib/grafana"; # default

      # root_url = "https://your.domain/grafana/"; # Not needed if it is `https://your.domain/`
      # serve_from_sub_path = true;
    };
  };
}
