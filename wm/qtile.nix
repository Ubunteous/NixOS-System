{ config, lib, ... }:

with lib;
let
  cfg = config.wm.qtile;
  wmcfg = config.wm;
in
{
  options.wm.qtile = {
    enable = mkEnableOption "Enables support for the Qtile windows manager (also exists as a Wayland compositor)";
  };

  config = mkIf (wmcfg.enable && cfg.enable) {
    # services.xserver.displayManager.defaultSession = "none+qtile";
    services.xserver.windowManager.qtile = {
      enable = true;

      # configFile = "$XDG_CONFIG_HOME/qtile/config.py"

      # extraPackages = python3Packages: with python3Packages; [
      #   qtile
      #   qtile-extras
      # ];

      backend = "x11"; # "wayland"
    };
  };
}
