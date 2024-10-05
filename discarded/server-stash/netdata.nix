{ config, lib, ... }:

with lib;
let
  cfg = config.lab.netdata;
  labcfg = config.lab;
  in {

    options.lab.netdata = {
    enable = mkEnableOption "Enables support for netdata";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.netdata = {
      enable = true;

      # package
      # group
      # user
      # deadlineBeforeStopSec
      # configDir
      # enableAnalyticsReporting
      # extraPluginPaths
      # configText
      # config
      # python.recommendedPythonPackages
      # python.extraPackages
      # python.enable
      # claimTokenFile

      # 19999
    };
  };
}
