{ config, lib, ... }:

with lib;
let
  cfg = config.lab.nzbget;
  labcfg = config.lab;
in {
  options.lab.nzbget = {
    enable = mkEnableOption "Enables support for nzbget";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    ######################
    #       DELUGE       #
    ######################

    services.nzbget = {
      enable = true;

      # see https://github.com/nzbget/nzbget/blob/master/nzbget.conf
      # settings = { MainDir = "/data"; };

      # package = pkgs.nzbget;
      # group = "nzbget";
      # user = "nzbget";
    };
  };
}
