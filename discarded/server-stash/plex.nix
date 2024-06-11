{ config, lib, ... }:

with lib;
let
  cfg = config.lab.plex;
  labcfg = config.lab;
in {

  options.lab.plex = { enable = mkEnableOption "Enables support for plex"; };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.plex = {
      # use with: 32400/web/
      enable = true;

      # extraPlugins = [];
      # extraScanners = [];

      # user = "plex";
      # group = "plex";

      # openFirewall = true;
      # dataDir = "/var/lib/plex";
    };
  };
}
