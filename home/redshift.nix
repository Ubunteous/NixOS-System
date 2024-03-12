{ config, lib, ... }:

with lib;
let
  cfg = config.home.redshift;
  labcfg = config.home;
in {

  options.home.redshift = {
    enable = mkEnableOption "Enables support for redshift";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    # once configured, redshift can be started:
    # manually: systemctl --user start redshift
    # automatically with empty file in:
    # ~/.config/systemd/user/default.target.wants/redshift.service

    services.redshift = {
      enable = true;

      latitude = "50"; # "-90.0" to "90.0"
      longitude = "0"; # "-180.0" to "180.0"

      dawnTime = "07:00";
      duskTime = "19:00";

      temperature = {
        # values from 1000 to 25000
        day = 5500; # 5500
        night = 3700; # 3700
      };

      # settings = {
      #   redshift = { adjustment-method = "randr"; };
      #   randr = { screen = 0; };
      # };

      # "manual" or "geoclue2" with geoclue2 service to enable
      # provider = null;

      # enableVerboseLogging = true;
      # tray = true; # needs redshift-gtk tray applet
    };
  };
}
