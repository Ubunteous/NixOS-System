{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.home.flameshot;
  homecfg = config.home;
  in {
    options.home.flameshot = {
      enable = mkEnableOption "Enable support for Flameshot";
  };

  config = mkIf (homecfg.enable && cfg.enable) {
    services.flameshot = {
      enable = true;
      settings = {
        General = {
          savePath = "${config.home.homeDirectory}/Pictures/Screenshots";
        };
      };
    };
  };
}
