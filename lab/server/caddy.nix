{ config, lib, ... }:

with lib;
let
  cfg = config.lab.caddy;
  labcfg = config.lab;
  in {

    options.lab.caddy = { enable = mkEnableOption "Enables support for caddy"; };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.caddy = {
      enable = true;

      # logDir = "/var/log/caddy"; # see option logFormat

      # globalConfig
      # extraConfig
      # dataDir
      # configFile

      # requires the admin API to not be turned off.
      # If enabled, set grace_period to a non-infinite value in services.caddy.globalConfig
      # enableReload = false; # true by default

      # virtualHosts.<name> = {
      #   useACMEHost
      #   serverAliases
      #   logFormat
      #   listenAddresses
      #   hostName
      #   extraConfig
      # };

      # not recommended. use configFile instead to avoid creating json config
      # settings

      # adapter
      # resume = true; # false by default

      # group = "caddy"; # caddy by default
      # user = "caddy"; # if default, create caddy user

      # # for certificates:
      # email
      # acmeCA
    };
  };
}
