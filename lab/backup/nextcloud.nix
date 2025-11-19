{ config, lib, ... }:

with lib;
let
  cfg = config.lab.nextcloud;
  labcfg = config.lab;
in {

  options.lab.nextcloud = {
    enable = mkEnableOption "Enables support for nextcloud";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.nextcloud = {
      enable = true;
      # datadir = cfg.services.nextcloud.home; # /var/lib/nextcloud
    };
  };
}
