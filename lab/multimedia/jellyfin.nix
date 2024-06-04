{ config, lib, ... }:

with lib;
let
  cfg = config.lab.jellyfin;
  labcfg = config.lab;
in {

  options.lab.jellyfin = {
    enable = mkEnableOption "Enables support for jellyfin";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    # services.jellyseerr.enable = true; # request manager

    services.jellyfin = {
      enable = true;

      # group = "jellyfin";
      # servicesuser = "jellyfin";

      # logDir = "\${cfg.dataDir}/log";
      # cacheDir = "/var/cache/jellyfin";

      # openFirewall = true;

      # dataDir = "/var/lib/jellyfin";
      # configDir = "\${cfg.dataDir}/config";
    };
  };

}
