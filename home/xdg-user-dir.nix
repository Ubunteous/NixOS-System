{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.home.xdg-user-dir;
  homecfg = config.home;
in
{
  options.home.xdg-user-dir = {
    enable = mkEnableOption "Enable support for xdg-user-dir";
  };

  config = mkIf (homecfg.enable && cfg.enable) {
    # Still experimental. Will be tested later.

    ###########
    #   XDG   #
    ###########

    xdg.userDirs.enable = true;   
  };
}
