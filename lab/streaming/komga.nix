{ config, lib, ... }:

with lib;
let
  cfg = config.lab.komga;
  labcfg = config.lab;
in {

  options.lab.komga = { enable = mkEnableOption "Enables support for komga"; };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.komga = {
      enable = true;
      openFirewall = true;
      settings.server.port = 8069; # 8080

      # group = "komga";
      user = "multimedia"; # fix for zfs only allowing user access on mount
      # stateDir = "/var/lib/komga";
    };
  };
}
