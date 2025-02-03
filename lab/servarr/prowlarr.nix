{ config, lib, ... }:

with lib;
let
  cfg = config.lab.prowlarr;
  labcfg = config.lab;
in {

  options.lab.prowlarr = {
    enable = mkEnableOption "Enables support for prowlarr";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.prowlarr = {
      enable = true;
      openFirewall = true;
    };
  };
}
