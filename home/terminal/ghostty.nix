{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.home.terminal.ghostty;
  homecfg = config.home;
  cfgterm = config.home.terminal;
in {
  options.home.terminal.ghostty = {
    enable = mkEnableOption "Enable support for Ghostty";
  };

  config = mkIf (homecfg.enable && cfg.enable) {
    ###############
    #   GHOSTTY   #
    ###############

    programs.ghostty = {
      enable = true;

      # clearDefaultKeybinds = false;

      enableBashIntegration = if cfgterm.bash.enable then true else false;
      enableFishIntegration = if cfgterm.fish.enable then true else false;
      enableZshIntegration = if cfgterm.zsh.enable then true else false;

      # installBatSyntax = true;
      # installVimSyntax = false;

      settings = {
        theme = "catppuccin-mocha";
        font-size = 24;
      };

      themes = {
        catppuccin-mocha = {
          background = "1e1e2e";
          cursor-color = "f5e0dc";
          foreground = "cdd6f4";
          palette = [
            "0=#45475a"
            "1=#f38ba8"
            "2=#a6e3a1"
            "3=#f9e2af"
            "4=#89b4fa"
            "5=#f5c2e7"
            "6=#94e2d5"
            "7=#bac2de"
            "8=#585b70"
            "9=#f38ba8"
            "10=#a6e3a1"
            "11=#f9e2af"
            "12=#89b4fa"
            "13=#f5c2e7"
            "14=#94e2d5"
            "15=#a6adc8"
          ];
          selection-background = "353749";
          selection-foreground = "cdd6f4";
        };
      };
    };
  };
}

