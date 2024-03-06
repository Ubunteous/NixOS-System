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
    # services.nginx.enable = true;
    services.nginx.virtualHosts."localhost" = {
      # virtualHosts.${config.services.grafana.settings.server.domain}

      # addSSL = true;
      # enableACME = true;

      locations."/" = {
        # proxyPass = "http://127.0.0.1:${toString config.services.grafana.port}";
        proxyWebsockets = true;
        recommendedProxySettings = true;
      };
    };
  };
}
