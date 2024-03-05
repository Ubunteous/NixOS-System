{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.home.terminal.kitty;
  homecfg = config.home;
in
{
  options.home.terminal.kitty = {
    enable = mkEnableOption "Enable support for Kitty";
  };

  config = mkIf (homecfg.enable && cfg.enable) {
    #############
    #   KITTY   #
    #############

    programs.kitty = {
      enable = true;
      theme = "Fish Tank";
      
      settings = {
        font_size = 24;
        font_family = "Fira Code";
        disable_ligatures = "never";

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
}
