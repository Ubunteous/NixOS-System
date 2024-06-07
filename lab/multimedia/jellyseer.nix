{ config, lib, ... }:

with lib;
let
  cfg = config.lab.jellyfin;
  labcfg = config.lab;
in {

  options.lab.jellyfin = {
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
