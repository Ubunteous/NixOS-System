{ config, lib, ... }:

with lib;
let
  cfg = config.lab.dhcpcd;
  corecfg = config.lab;
in {

  options.lab.dhcpcd = {
    enable = mkEnableOption "Enables support for dhcpcd";
  };

  config = mkIf (corecfg.enable && cfg.enable) {
    networking.dhcpcd = {
      enable = true;

      # wait = "any";
      # IPv6rs = null; # boolean
      # persistent = false;
      # setHostname = true;
      # allowSetuid = false;

      # runHook = "";
      # extraConfig = "";

      # denyInterfaces = [];
      # allowInterfaces = null;
    };
  };
}
