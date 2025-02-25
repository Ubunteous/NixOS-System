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
      port = 8069; # 8080

      # group = "komga";
      # user = "komga";
      # stateDir = "/var/lib/komga";
    };
  };
}
