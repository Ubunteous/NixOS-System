{ config, lib, ... }:

with lib;
let
  cfg = config.wm.sway;
  wmcfg = config.wm;
in
{
  options.wm.sway = {
    enable = mkEnableOption "Enables support for the Sway compositor";
  };

  config = mkIf (wmcfg.enable && cfg.enable) {
    # Enable the Sway Compositor.
    programs.sway.enable = true;
  };
}
