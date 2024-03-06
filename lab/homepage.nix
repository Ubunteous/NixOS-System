{ config, lib, ... }:

with lib;
let
  cfg = config.lab.homepage;
  labcfg = config.lab;
in {
  options.lab.homepage = {
    enable = mkEnableOption "Enables support for Homepage";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    ####################
    #     HOMEPAGE     #
    ####################

    services.homepage-dashboard = {
      enable = true;

      # http://localhost:8082/
      # listenPort = 8082; # default is 8082

      # Open ports in the firewall for Homepage
      # openFirewall = true;
    };
  };
}

