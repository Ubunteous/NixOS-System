{ config, lib, ... }:

with lib;
let
  cfg = config.lab.navidrome;
  corecfg = config.lab;
in {

  options.lab.navidrome = {
    enable = mkEnableOption "Enables support for Navidrome";
  };

  config = mkIf (corecfg.enable && cfg.enable) {
    services.navidrome = {
      enable = true;

      openFirewall = true;

      # settings = {
      # 	Port = 4533;
      # 	Address = "127.0.0.1";	
      # };

      # user = "navidrome";
      # group = "navidrome";
    };
  };
}
