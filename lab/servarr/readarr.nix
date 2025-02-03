{ config, lib, ... }:

with lib;
let
  cfg = config.lab.readarr;
  labcfg = config.lab;
in {

  options.lab.readarr = {
    enable = mkEnableOption "Enables support for readarr";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.readarr = {
      enable = true;

      # user = "readarr";
      # group = "readarr";

      # dataDir = "/var/lib/readarr/";
      openFirewall = true;
    };
  };
}
