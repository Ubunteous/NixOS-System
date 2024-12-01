{ config, lib, ... }:

with lib;
let
  cfg = config.lab.caddy;
  labcfg = config.lab;
in {

  options.lab.caddy = { enable = mkEnableOption "Enables support for caddy"; };

  config = mkIf (labcfg.enable && cfg.enable) {
    # open port needed by caddy
    # networking.firewall.allowedTCPPorts= [ ];

    services.caddy = {
      enable = true;

      # test caddy with: curl localhost:2019/config/
      # test redirects with: curl localhost -i -L -k
      virtualHosts."localhost" = {
        extraConfig = ''
          respond "Hello, world!"
          redir /redir /
        '';

        serverAliases = [ "127.0.0.1" "localhost" ];
      };

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
