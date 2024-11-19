{ config, lib, ... }:

with lib;
let
  cfg = config.lab.bind;
  corecfg = config.lab;
in {

  options.lab.ssh = { enable = mkEnableOption "Enables support for Bind DNS"; };

  config = mkIf (corecfg.enable && cfg.enable) {
    services.bind = {
      enable = true;

      ###########
      # DEFAULT #
      ###########

      # package = pkgs.bind;
      # listenOnIpv6 = [ "any" ];
      # listenOn = [ "any" ];
      # ipv4Only = false;
      # forwarders = config.networking.nameservers; # [ "" "" ]
      # forward = "first"; # "first" or "only"
      # extraOptions = "";
      # extraConfig = "";
      # directory = "/run/named";
      # configFile = confFile;
      # blockedNetworks = [ ];

      # zones."example.com" = {
      #   master = true;
      #   name = "example.com";
      #   slaves = [];
      #   masters = [ "" "" ];
      #   file = "/path/to/file/";
      #   extraConfig = '' '';
      #   allowQuery = [ "any" ];
      # };

      #################################
      # SERVING DNS FOR CUSTOM DOMAIN #
      #################################

      # zones."example.com" = {
      #   master = true;

      #   name = "example.com";

      # 	file = pkgs.writeText "zone-example.com" ''
      #     $ORIGIN example.com.
      #     $TTL    1h
      #     @            IN      SOA     ns1 hostmaster (
      #                                      1    ; Serial
      #                                      3h   ; Refresh
      #                                      1h   ; Retry
      #                                      1w   ; Expire
      #                                      1h)  ; Negative Cache TTL
      #                  IN      NS      ns1
      #                  IN      NS      ns2

      #     @            IN      A       203.0.113.1
      #                  IN      AAAA    2001:db8:113::1
      #                  IN      MX      10 mail
      #                  IN      TXT     "v=spf1 mx"

      #     www          IN      A       203.0.113.1
      #                  IN      AAAA    2001:db8:113::1

      #     ns1          IN      A       203.0.113.4
      #                  IN      AAAA    2001:db8:113::4

      #     ns2          IN      A       198.51.100.5
      #                  IN      AAAA    2001:db8:5100::5
      #   '';

      # 	# slaves = [];
      #   # masters = [ "" "" ];
      #   # file = "/path/to/file/";
      #   # extraConfig = '' '';
      #   # allowQuery = [ "any" ];
      # };

      ######################
      # SPLIT DNS RESOLVER #
      ######################

      # cacheNetworks = [ "127.0.0.0/24" "::1/128" "192.168.0.0/24" ];

      # zones = {
      #   "example.com" = {
      #     master = true;
      #     allowQuery = [ "127.0.0.0/24" "::1/128" "192.168.0.0/24" ];
      #     file = pkgs.writeText "zone-example.com" "";
      #   };
      # };

    };
  };
}
