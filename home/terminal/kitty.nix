{ config, lib, pkgs, home-manager, user, ... }:

with lib;
let
  cfg = config.home.terminal.kitty;
in
{
  options.home.terminal.kitty = {
    enable = mkEnableOption "Enable support for Kitty";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user} = {
      #############
      #   KITTY   #
      #############

      programs.kitty = {
        enable = true;
        theme = "Fish Tank";
        
        settings = {
          font_size = 24;
          shell = "fish";
          cursor_blink_interval = 0;

          enable_audio_bell = false;
          update_check_interval = 0;
          confirm_os_window_close = 0;
          # focus_follow_mouse = "yes"; # deprecated
          # font
        };
      };
    };
  };
}
