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
    ###########
    # GRAFANA #
    ###########

    services.grafana = {
      enable = true;
      # domain = "grafana.pele";
      settings.server = {
        http_port = 2342; # or 3000
        http_addr = "127.0.0.1";

        # Grafana needs to know on which domain and URL it's running
        # domain = "your.domain";
        # root_url = "https://your.domain/grafana/"; # Not needed if it is `https://your.domain/`
        # serve_from_sub_path = true;
      };
    };

    #########
    # NGINX #
    #########

    #   services.nginx = {
    #     enable = true;

    #     virtualHosts."your.domain" = {
    #       addSSL = true;
    #       enableACME = true;
    #       locations."/grafana/" = {
    #         proxyPass = "http://${toString config.services.grafana.settings.server.http_addr}:${toString config.services.grafana.settings.server.http_port}";
    #         proxyWebsockets = true;
    #         recommendedProxySettings = true;
    #       };
    #     };
    #   };
    # };

    ##############
    # PROMETHEUS #
    ##############

    # hosts/chrysalis/configuration.nix
    services.prometheus = {
      enable = true;
      port = 9001;

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
  };
}

  ########
  # LOKI #
  ########

  #   services.loki = {
  #     enable = true;
  #     user = "${user}";
  #     # group

  #     # configFile = ./loki-local-config.yaml;
  #     # server:
  #     # http_listen_port: 28183
  #     #   grpc_listen_port: 0

  #     #     positions:
  #     # filename: /tmp/positions.yaml

  #     #   clients:
  #     # - url: http://127.0.0.1:3100/loki/api/v1/push

  #     #   scrape_configs:
  #     # - job_name: journal
  #     #   journal:
  #     # max_age: 12h
  #     #   labels:
  #     # job: systemd-journal
  #     #   host: chrysalis
  #     #     relabel_configs:
  #     # - source_labels: ["__journal__systemd_unit"]
  #     #   target_label: "unit"



  #     configuration = ''
  #       # Enables authentication through the X-Scope-OrgID header, which must be present
  #       # if true. If false, the OrgID will always be set to "fake".
  #       auth_enabled: false

  #       server:
  #         http_listen_address: "0.0.0.0"
  #         http_listen_port: 3100

  #       ingester:
  #         lifecycler:
  #           address: "127.0.0.1"
  #           ring:
  #             kvstore:
  #               store: inmemory
  #             replication_factor: 1
  #           final_sleep: 0s
  #         chunk_idle_period: 5m
  #         chunk_retain_period: 30s

  #       schema_config:
  #         configs:
  #         - from: 2020-05-15
  #           store: boltdb
  #           object_store: filesystem
  #           schema: v11
  #           index:
  #             prefix: index_
  #             period: 168h

  #       storage_config:
  #         boltdb:
  #           directory: /tmp/loki/index

  #         filesystem:
  #           directory: /tmp/loki/chunks

  #       limits_config:
  #         enforce_metric_name: false
  #         reject_old_samples: true
  #         reject_old_samples_max_age: 168h
  #     '';
  #   };
  # };

  #############
  # PROMPTAIL #
  #############

  # # hosts/chrysalis/configuration.nix
  # systemd.services.promtail = {
  #   description = "Promtail service for Loki";
  #   wantedBy = [ "multi-user.target" ];

  #   serviceConfig = {
  #     ExecStart = ''
  #       ${pkgs.grafana-loki}/bin/promtail --config.file ${./promtail.yaml}
  #     '';
  #   };
  # };

  #   };
  # }
