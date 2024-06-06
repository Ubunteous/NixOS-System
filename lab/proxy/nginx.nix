{ config, lib, ... }:

# see https://xeiaso.net/blog/prometheus-grafana-nginx-nixos-2020-11-20/

with lib;
let
  cfg = config.lab.nginx;
  labcfg = config.lab;
in {
  options.lab.nginx = { enable = mkEnableOption "Enables support for NGinx"; };

  config = mkIf (labcfg.enable && cfg.enable) {
    #########
    # NGINX #
    #########

    # nginx reverse proxy
    services.nginx = {
      enable = true;

      recommendedProxySettings = true;
      recommendedTlsSettings = true;

      # ${config.services.grafana.settings.server.domain}
      virtualHosts."localhost" = {
        locations."/var/html" = {
          # ${toString grafana...server.http_addr}
          # :${toString grafana...server.http_port}";

          proxyPass = "http://127.0.0.1:3002/";
          # proxyWebsockets = true;
          # recommendedProxySettings = true;
        };
      };
    };
  };
}
