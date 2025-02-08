{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.lab.sabnzbd;
  labcfg = config.lab;
in {
  # imports = [ ../../modules/sabnzbd.nix ];

  options.lab.sabnzbd = { enable = mkEnableOption "Enables sabnzbd"; };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.sabnzbd = {
      enable = true;
      openFirewall = true;

      ###############
      #   DEFAULT   #
      ###############

      # configFile = "/var/lib/sabnzbd/sabnzbd.ini";
      # package = pkgs.stable.sabnzbd;
      # user = "sabnzbd";
      # group = "sabnzbd";
    };
  };
}
