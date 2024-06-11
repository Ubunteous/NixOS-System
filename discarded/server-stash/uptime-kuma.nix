{ config, lib, ... }:

with lib;
let
  cfg = config.lab.uptime-kuma;
  labcfg = config.lab;
  in {

    options.lab.uptime-kuma = {
    enable = mkEnableOption "Enables support for uptime-kuma";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.uptime-kuma = {
      # resides on port 3001
      enable = true;

      # settings = {
      #   NODE_EXTRA_CA_CERTS = "/etc/ssl/certs/ca-certificates.crt";
      #   PORT = "4000";
      # };

      # appriseSupport = true;
    };
  };
}
