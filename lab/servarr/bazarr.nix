{ config, lib, ... }:

with lib;
let
  cfg = config.lab.bazarr;
  labcfg = config.lab;
in {

  options.lab.bazarr = {
    enable = mkEnableOption "Enables support for bazarr";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.bazarr = {
      enable = true;

      # user = "bazarr";
      # group = "bazarr";

      openFirewall = true;
      # listenPort = 6767; # defaults to 6767
    };
  };
}
