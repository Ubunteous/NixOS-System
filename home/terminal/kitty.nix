{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.home.terminal.kitty;
  homecfg = config.home;
  cfgterm = config.home.terminal;
in {
  options.home.terminal.kitty = {
    enable = mkEnableOption "Enable support for Kitty";
  };

  config = mkIf (homecfg.enable && cfg.enable) {
    #############
    #   KITTY   #
    #############

    programs.kitty = {
      enable = true;
      themeFile = "FishTank";

      settings = {
        font_size = 24;
        font_family = "Fira Code";
        disable_ligatures = "never";

        shell = if cfgterm.fish.enable then
          "fish"
        else if cfgterm.zsh.enable then
          "zsh"
        else
          "bash";

        cursor_blink_interval = 0;

        enable_audio_bell = false;
        update_check_interval = 0;
        confirm_os_window_close = 0;
        # focus_follow_mouse = "yes"; # deprecated
        # font
      };

      shellIntegration = {
        enableFishIntegration = if cfgterm.fish.enable then true else false;
        enableBashIntegration =
          if !cfgterm.fish.enable && cfgterm.bash.enable then true else false;
        enableZshIntegration =
          if !cfgterm.fish.enable && cfgterm.zsh.enable then true else false;
      };
    };
  };
}
