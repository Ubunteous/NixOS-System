{ config, lib, ... }:

with lib;
let
  cfg = config.lab.lidarr;
  labcfg = config.lab;
in {

  options.lab.lidarr = {
    enable = mkEnableOption "Enables support for lidarr";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.lidarr = {
      enable = true;

      # user = "lidarr";
      # group = "lidarr";

      # dataDir = "/var/lib/lidarr/.config/Lidarr";
      # openFirewall = true;
    };
  };
}
