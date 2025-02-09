{ config, lib, ... }:

with lib;
let
  cfg = config.lab.flaresolverr;
  labcfg = config.lab;
in {

  options.lab.flaresolverr = {
    enable = mkEnableOption "Enables support for flaresolverr";
  };

  config = mkIf (labcfg.enable && cfg.enable) {

    services.flaresolverr = {
      enable = true;

      openFirewall = true;

      # port = 8191;
      # package = pkgs.flaresolverr;
    };
  };
}
