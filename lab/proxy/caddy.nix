{ config, lib, user, ... }:

with lib;
let
  cfg = config.lab.caddy;
  labcfg = config.lab;
in {

  options.lab.caddy = { enable = mkEnableOption "Enables support for caddy"; };

  config = mkIf (labcfg.enable && cfg.enable) {
    # open port needed by caddy
    networking.firewall.allowedTCPPorts = [ 2016 ];

    services.caddy = {
      enable = true;

      # test caddy with: curl localhost:2019/config/
      # test redirects with: curl localhost -i -L -k
      virtualHosts = {
        # ":2015" = { # port 2015 response
        #   extraConfig = ''
        #     encode gzip
        #     respond "Hello, world!"
        #     redir /redir /
        #   '';

        # serverAliases = [ "127.0.0.1" "localhost" "test" ];
        # };

        ":2016" = {
          # port 2016 file server
          # can't access /home/user without authorization
          # use instead root * /var/www/ after creating it
          extraConfig = ''
            root * /var/servarr/
            file_server browse
          '';
        };

        # ":80" = { # redir/rewrite do not seem to work to add /
        #   extraConfig = ''
        #     reverse_proxy radarr/ :7878
        #   '';
        # };

        # access from self
        "subdomain.localhost" = {
          extraConfig = ''
            reverse_proxy localhost:8082
          '';
        };

        # access from lan
        "192.168.1.99:80" = {
          extraConfig = ''
            reverse_proxy 192.168.1.99:8082
          '';
        };
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
