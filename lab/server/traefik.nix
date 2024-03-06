{ config, lib, ... }:

with lib;
let
  cfg = config.lab.traefik;
  labcfg = config.lab;
in {
  options.lab.traefik = {
    enable = mkEnableOption "Enables support for traefik";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.traefik = {

      enable = true;
      # dataDir # defaults to "/var/lib/traefik"
      # group # defaults to "traefik". could be set to "docker"

      # staticConfigFile
      # staticConfigOptions

      # dynamicConfigFile
      # dynamicConfigOptions

      # environmentFiles
    };
  };
}
