{ config, lib, ... }:

# see https://xeiaso.net/blog/prometheus-grafana-loki-nixos-2020-11-20/

with lib;
let
  cfg = config.lab.prometheus;
  labcfg = config.lab;
in {
  options.lab.prometheus = {
    enable = mkEnableOption "Enables support for Prometheus";
  };

  config = mkIf (labcfg.enable && cfg.enable) {

    ##############
    # PROMETHEUS #
    ##############

    services.prometheus = {
      enable = true;

      # port = 9090; # default

      exporters = {
        node = {
          enable = true;
          enabledCollectors = [ "systemd" ];
          # port = 9100; # default
        };
      };

      scrapeConfigs = [{
        job_name = "server";
        static_configs = [{
          targets = [
            # should match exporters.node.port
            "127.0.0.1:9100"
          ];
          # targets = [ "127.0.0.1:${toString config.services.prometheus.exporters.node.port}" ];
        }];
      }];

    };
  };
}
