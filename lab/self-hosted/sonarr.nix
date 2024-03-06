{ config, lib, ... }:

with lib;
let
  cfg = config.lab.sonarr;
  labcfg = config.lab;
in {

  options.lab.sonarr = {
    enable = mkEnableOption "Enables support for sonarr";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.sonarr = {
      enable = true;

      # user = "sonarr";
      # group = "sonarr";

      # openFirewall = true;
      # dataDir = "/var/lib/sonarr/.config/NzbDrone";
    };
  };
}
