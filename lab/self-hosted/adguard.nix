{ config, lib, ... }:

with lib;
let
  cfg = config.lab.adguard;
  labcfg = config.lab;
in {

  options.lab.adguard = {
    enable = mkEnableOption "Enables support for adguard";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.adguardhome = {
      enable = true;

      # extraArgs = [];
      # allowDHCP = config.services.adguardhome.settings.dhcp.enabled or false

      # openFirewall = true;
      # mutableSettings = false;

      # settings = {
      #   bind_port = 3002; # defaults to 3000
      #   bind_host = "127.0.0.1"; # defaults to "0.0.0.0";
      # };
    };
  };
}
