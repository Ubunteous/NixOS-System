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

      latitude = "0"; # "-90.0" to "90.0"
      longitude = "0"; # "-180.0" to "180.0"

      dawnTime = "05:00";
      duskTime = "05:00";

      temperature = {
        # Default values:
        # Daytime temperature: 6500K
        # Night temperature: 4500K
        # values from 1000 to 25000
        day = 6000; # 5500
        night = 6000; # 3700
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
