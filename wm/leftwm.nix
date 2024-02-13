{ config, lib, ... }:

with lib;
let
  cfg = config.wm.leftwm;
  wmcfg = config.wm;
in
{
  options.wm.leftwm = {
    enable = mkEnableOption "Enables support for the Left windows manager";
  };

  config = mkIf (wmcfg.enable && cfg.enable) {
    # Enable the Left Window Manager.
    # services.xserver.displayManager.defaultSession = "none+leftwm";
    services.xserver.windowManager.leftwm.enable = true;
  };
}
