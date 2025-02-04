{ config, lib, ... }:

with lib;
let
  cfg = config.lab.flood;
  labcfg = config.lab;
in {
  options.lab.flood = { enable = mkEnableOption "Enables support for flood"; };

  config = mkIf (labcfg.enable && cfg.enable) {
    #####################
    #       FLOOD       #
    #####################

    services.flood = {
      enable = true;

      openFirewall = true;
      host = "::"; # defaults to "localhost"
      port = 3001;

      # extraArgs = [ "--baseuri=/" ];
      # package = pkgs.flood;
    };
  };
}
