{ config, lib, ... }:

with lib;
let
  cfg = config.lab.cockpit;
  labcfg = config.lab;
in {

  options.lab.cockpit = {
    enable = mkEnableOption "Enables support for cockpit";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.cockpit = {
      enable = true;

      # settings = {};
      # openFirewall = true;
      port = 9099; # defaults to 9090
    };
  };
}
