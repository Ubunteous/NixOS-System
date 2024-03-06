{ config, user, lib, ... }:

# see https://xeiaso.net/blog/prometheus-grafana-loki-nixos-2020-11-20/

with lib;
let
  cfg = config.lab.loki;
  labcfg = config.lab;
in {
  options.lab.loki = { enable = mkEnableOption "Enables support for Loki"; };

  config = mkIf (labcfg.enable && cfg.enable) {
    ########
    # LOKI #
    ########

    services.loki = {
      enable = true;
      # user = "loki";

      # useLocally = true;

      configuration = {
        server.http_listen_port = 3030;
        auth_enabled = false;
      };

      # configuration = {
      #   server.http_listen_port = 3030;
      #   auth_enabled = false;

      # ingester = {
      #   lifecycler = {
      #     address = "127.0.0.1";
      #     ring = {
      #       kvstore = { store = "inmemory"; };
      #       replication_factor = 1;
      #     };
      #   };
      #   chunk_idle_period = "1h";
      #   max_chunk_age = "1h";
      #   chunk_target_size = 999999;
      #   chunk_retain_period = "30s";
      #   max_transfer_retries = 0;
      # };

      # schema_config = {
      #   configs = [{
      #     from = "2022-06-06";
      #     store = "boltdb-shipper";
      #     object_store = "filesystem";
      #     schema = "v11";
      #     index = {
      #       prefix = "index_";
      #       period = "24h";
      #     };
      #   }];
      # };

      # storage_config = {
      #   boltdb_shipper = {
      #     active_index_directory = "/var/lib/loki/boltdb-shipper-active";
      #     cache_location = "/var/lib/loki/boltdb-shipper-cache";
      #     cache_ttl = "24h";
      #     shared_store = "filesystem";
      #   };

      #   filesystem = { directory = "/var/lib/loki/chunks"; };
      # };

      # limits_config = {
      #   reject_old_samples = true;
      #   reject_old_samples_max_age = "168h";
      # };

      # chunk_store_config = { max_look_back_period = "0s"; };

      # table_manager = {
      #   retention_deletes_enabled = false;
      #   retention_period = "0s";
      # };

      # compactor = {
      #   working_directory = "/var/lib/loki";
      #   shared_store = "filesystem";
      #   compactor_ring = { kvstore = { store = "inmemory"; }; };
      # };
      # };

      # configFile = ./loki-local-config.yaml;
    };

    # hosts/chrysalis/configuration.nix
    # systemd.services.promtail = {
    #   description = "Promtail service for Loki";
    #   wantedBy = [ "multi-user.target" ];

    #   serviceConfig = {
    #     ExecStart = ''
    #       ${pkgs.grafana-loki}/bin/promtail --config.file ${./promtail.yaml}
    #     '';
    #   };
    # };
  };

  # services.promtail = {
  #   enable = true;
  #   # services.promtail.configuration
  #   # services.promtail.extraFlags
  # };
}
