{ config, lib, pkgs, home-manager, user, ... }:

with lib;
let
  cfg = config.home.xdg-user-dir;
in
{
  options.home.xdg-user-dir = {
    enable = mkEnableOption "Enable support for xdg-user-dir";
  };

  config = mkIf cfg.enable {
    # Still experimental. Will be tested later.

    ###########
    #   XDG   #
    ###########

    home-manager.users.${user} = {
      xdg.userDirs.enable = true;   
    };
  };
}
