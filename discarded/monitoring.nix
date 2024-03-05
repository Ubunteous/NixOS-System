{ config, user, lib, ... }:

# see https://xeiaso.net/blog/prometheus-grafana-loki-nixos-2020-11-20/

with lib;
let
  cfg = config.core.monitoring;
  corecfg = config.core;
in
{
  options.core.monitoring = {
    enable = mkEnableOption "Enables support for Prometheus, Loki and Grafana";
  };

  config = mkIf (corecfg.enable && cfg.enable) {

    ##############
    # PROMETHEUS #
    ##############

    # start with http://localhost:9001/graph
    # default port is 9090
    services.prometheus = {
      enable = true;
      port = 9001; # default is 9090

      exporters = {
        node = {
          enable = true;
          enabledCollectors = [ "systemd" ];
          port = 9002;
        };
      };
      
      scrapeConfigs = [
        {
          job_name = "chrysalis";
          static_configs = [{
            targets = [ "127.0.0.1:${toString config.services.prometheus.exporters.node.port}" ];
          }];
        }
      ];
    };

    ###########
    # GRAFANA #
    ###########

    # go to http://localhost:3000/ and log with admin / admin
    services.grafana = {
      enable = true;
      settings.server = {
        http_port = 3000; # default is 3000
        domain = "localhost";
        protocol = "http";
      };
      
      dataDir = "/var/lib/grafana";

      # settings.server = {
      # http_port = 2342; # or 3000
      # http_addr = "127.0.0.1";

      # Grafana needs to know on which domain and URL it's running
      # domain = "your.domain";
      # root_url = "https://your.domain/grafana/"; # Not needed if it is `https://your.domain/`
      # serve_from_sub_path = true;
    };

    #########
    # NGINX #
    #########

    # nginx reverse proxy
    # services.nginx.enable = true;
    services.nginx.virtualHosts.${config.services.grafana.settings.server.domain} = {
      # addSSL = true;
      # enableACME = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:${toString config.services.grafana.port}";
        proxyWebsockets = true;
        recommendedProxySettings = true;
      };
    };

    
    ########
    # LOKI #
    ########

    # services.loki = {
    #   enable = true;
    #   user = "${user}";

    #   configFile = ./loki-local-config.yaml;
    # };
    
    # # hosts/chrysalis/configuration.nix
    # systemd.services.promtail = {
    #   description = "Promtail service for Loki";
    #   wantedBy = [ "multi-user.target" ];

    #   serviceConfig = {
    #     ExecStart = ''
    #     ${pkgs.grafana-loki}/bin/promtail --config.file ${./promtail.yaml}
    #   '';
    #   };
    # };    
  };
}
