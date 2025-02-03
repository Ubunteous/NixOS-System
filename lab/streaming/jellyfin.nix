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

    services.jellyfin = {
      enable = true;

      # for lan access and more
      openFirewall = true;

      # grant access to media with chown or create /home/jellyfin
      # group = "jellyfin";
      # user = "jellyfin";

      # logDir = "\${cfg.dataDir}/log";
      # cacheDir = "/var/cache/jellyfin";

      # dataDir = "/var/lib/jellyfin";
      # configDir = "\${cfg.dataDir}/config";
    };
  };
}
