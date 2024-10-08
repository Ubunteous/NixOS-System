{ config, lib, ... }:

with lib;
let
  cfg = config.lab.tautulli;
  labcfg = config.lab;
in {

  options.lab.tautulli = {
    enable = mkEnableOption "Enables support for tautulli";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.tautulli = {
      enable = true;

      # openFirewall = false;
      # configFile = "/var/lib/plexpy/config.ini";
      # port = 8181;
      # group = "nogroup";
      # user = "plexpy";
      # dataDir = "/var/lib/plexpy";
    };
  };
}
