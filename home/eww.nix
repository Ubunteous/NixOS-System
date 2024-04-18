{ config, lib, ... }:

with lib;
let
  cfg = config.home.eww;
  homecfg = config.home;
in {
  options.home.eww = { enable = mkEnableOption "Enable support for Eww"; };

  config = mkIf (homecfg.enable && cfg.enable) {
    ###########
    #   EWW   #
    ###########

    programs.eww = {
      enable = true;
      # configDir = "";    
    };
  };
}
