{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.wm.hyprland;
  wmcfg = config.wm;
in
{
  options.wm.hyprland = {
    enable = mkEnableOption "Enables support for the Hyprland compositor";
  };

  config = mkIf (wmcfg.enable && cfg.enable) {
    # Enable the Hyprland Compositor.
    programs.hyprland.enable = true;

    users.users.${user}.packages = with pkgs; [ hyprpaper ];
  };
}
