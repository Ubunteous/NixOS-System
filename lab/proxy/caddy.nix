{ config, lib, ... }:

with lib;
let
  cfg = config.lab.caddy;
  labcfg = config.lab;

  servicesPort = {
    # servarr
    "radarr".port = config.services.radarr.settings.server.port;
    "bazarr".port = config.services.bazarr.settings.server.port;
    "sonarr".port = config.services.sonarr.settings.server.port;
    "lidarr".port = config.services.lidarr.settings.server.port;
    # "readarr".port = config.services.readarr.settings.server.port;
    "prowlarr".port = config.services.prowlarr.settings.server.port;

    # streaming
    "plex".port = "32400/web";
    "navidrome".port = config.services.navidrome.settings.Port;
    "komga".port = config.services.komga.settings.server.port;

    # backups
    "filebrowser".port = config.services.filebrowser.port;

    # misc
    "adguard".port = config.services.services.adguardhome.port;
    "qbittorrent-nox".port = config.services.qbittorrent-nox.port;
  };
in {

  options.lab.caddy = {
    enable = mkEnableOption "Enables support for caddy";

    domain = mkOption {
      type = types.str;
      default = "server.local";
      description = lib.mdDoc ''
        Server domain in local network.
      '';
    };

  };

  config = mkIf (labcfg.enable && cfg.enable) {

    networking.hosts = {
      "127.0.0.1" = map (x: "${x}.${cfg.domain}") (attrNames servicesPort)
        ++ [ "${cfg.domain}" "gitea.${cfg.domain}" "caddy.${cfg.domain}" ];
    };

    # open port needed by caddy file server
    networking.firewall.allowedTCPPorts = [ 2016 ];

    services.caddy = {
      enable = true;

      # test caddy with: curl localhost:2019/config/
      # test redirects with: curl localhost -i -L -k
      virtualHosts = {
        "http://gitea.${cfg.domain}" =
          mkIf (labcfg.git.enable && labcfg.git.webUI == "gitea") {
            extraConfig = "reverse_proxy localhost:3000";
          };

        "http://${cfg.domain}" = mkIf labcfg.homepage.enable {
          extraConfig = "reverse_proxy localhost:8082";
        };

        "http://caddy.${cfg.domain}".extraConfig =
          "reverse_proxy localhost:2016";

        # port 2016 file server
        # can't access /home/user without authorization
        # use instead root * /var/www/ after creating it
        ":2016".extraConfig = ''
          root * ${labcfg.dataDir}
          file_server browse
        '';
        # ":2015" = { # port 2015 response
        #   extraConfig = ''
        #     encode gzip
        #     respond "Hello, world!"
        #     redir /redir /
        #   '';

        # serverAliases = [ "127.0.0.1" "localhost" "test" ];
        # };
      } // mapAttrs (service: port:
        mkIf labcfg.${service}.enable {
          "http://${service}.${cfg.domain}".extraConfig =
            "reverse_proxy localhost:${port}";
        }) servicesPort;

      # # recommended over caddy.settings
      # configFile = pkgs.writeText "Caddyfile" ''
      #   example.com
      #   root * /var/www/wordpress
      #   php_fastcgi unix//run/php/php-version-fpm.sock
      #   file_server
      # '';

      # virtualHosts.<name> = {
      #   useACMEHost
      #   serverAliases
      #   logFormat
      #   listenAddresses
      #   hostName
      #   extraConfig
      # };

      # extraConfig

      # requires the admin API to not be turned off.
      # If enabled, set grace_period to a non-infinite value in globalConfig

      ####################
      #   certificates   #
      ####################

      # email
      # acmeCA

      ###############
      #   default   #
      ###############

      # logDir = "/var/log/caddy"; # see option logFormat
      # dataDir = "/var/lib/caddy";

      # json config. not recommended. use configFile instead
      # settings # prefer a caddyfile instead

      # adapter
      # resume = true; # false by default

      # enableReload = false; # true by default

      # group = "caddy"; # caddy by default
      # user = "caddy"; # if default, create caddy user
    };
  };
}
