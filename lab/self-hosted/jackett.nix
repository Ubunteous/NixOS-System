{ config, lib, ... }:

with lib;
let
  cfg = config.lab.jackett;
  labcfg = config.lab;
in {

  options.lab.jackett = {
    enable = mkEnableOption "Enables support for jackett";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.jackett = {
      enable = true;

      # user = "jackett";
      # group = "jackett";

      # openFirewall = true;
      # dataDir = "/var/lib/jackett/.config/Jackett";
    };
  };

}
