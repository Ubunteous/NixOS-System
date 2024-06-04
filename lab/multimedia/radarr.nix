{ config, lib, ... }:

with lib;
let
  cfg = config.lab.radarr;
  labcfg = config.lab;
in {

  options.lab.radarr = {
    enable = mkEnableOption "Enables support for radarr";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.radarr = {
      enable = true;

      # user = "radarr";
      # group = "radarr";

      # openFirewall = true;
      # dataDir = "/var/lib/radarr/.config/Radarr";
    };
  };
}
