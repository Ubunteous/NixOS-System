{ config, lib, ... }:

with lib;
let
  cfg = config.lab.jellyseer;
  labcfg = config.lab;
in {

  options.lab.jellyseer = {
    enable = mkEnableOption "Enables support for jellyfin";
  };

  config = mkIf (labcfg.enable && cfg.enable) {

    services.jellyseerr = {
      enable = true;
      # port = 5055;
      openFirewall = true;
    };
  };
}
