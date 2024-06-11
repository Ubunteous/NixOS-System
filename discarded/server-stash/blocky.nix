{ config, lib, ... }:

with lib;
let
  cfg = config.lab.blocky;
  labcfg = config.lab;
  in {

    options.lab.blocky = {
    enable = mkEnableOption "Enables support for blocky DNS";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.blocky = {
      enable = true;
      settings = { };
    };
  };
}
