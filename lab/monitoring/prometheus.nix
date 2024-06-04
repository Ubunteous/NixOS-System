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

      port = 9090; # default is 9090

      exporters = {
        node = {
          enable = true;
          enabledCollectors = [ "systemd" ];
          port = 9091;
        };
      };

      scrapeConfigs = [{
        job_name = "chrysalis";
        static_configs = [{
          targets = [
            # should match exporters.node.port
            "127.0.0.1:9091"
          ];
        }];
      }];
    };
  };
}
