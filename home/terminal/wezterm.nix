{ config, lib, ... }:

with lib;
let
  cfg = config.home.terminal.wezterm;
  homecfg = config.home;
in {
  options.home.terminal.wezterm = {
    enable = mkEnableOption "Enable support for Wezterm";
  };

  config = mkIf (homecfg.enable && cfg.enable) {
    ###############
    #   WEZTERM   #
    ###############

    # prevent creation of ~/.config/wezterm/wezterm.lua
    # xdg.configFile."wezterm/wezterm.lua".enable = false;
    xdg.configFile."wezterm/".source = ../../files/wezterm;

    dconf.settings = {
      "org/cinnamon/desktop/applications/terminal" = {
        exec = "wezterm";
        # exec-arg = ""; # argument
      };
    };

    programs.wezterm = {
      enable = true;

      # package = pkgs.stable.wezterm;

      # colorSchemes = {
      #   default = {
      #     ansi = [ "#222222" "#D14949" "#48874F" "#AFA75A"    "#599797" "#8F6089" "#5C9FA8" "#8C8C8C" ];
      #     brights = [ "#444444" "#FF6D6D" "#89FF95" "#FFF484"    "#97DDFF" "#FDAAF2" "#85F5DA" "#E9E9E9" ];
      #     # background = "#1B1B1B";
      #     background = "#FF0000";
      #     cursor_bg = "#BEAF8A";
      #     cursor_border = "#BEAF8A";
      #     cursor_fg = "#1B1B1B";
      #     foreground = "#BEAF8A";
      #     selection_bg = "#444444";
      #     selection_fg = "#E9E9E9";
      #   };
      # };

      # extraConfig = ''
      #   return {
      #     -- color_scheme = "Monokai Remastered",
      #     color_scheme = "AdventureTime",

      #     -- colors, metadata = wezterm.color.load_scheme("~/.config/.wezterm/colors/default.toml")
      #     -- pcall(wezterm.color.load_scheme, wezterm.home_dir .. "/.config/wezterm/colors/default.toml")

      #     font_size = 28,

      #     -- Spawn a bash shell
      #     default_prog = { "/run/current-system/sw/bin/bash" },
      #   }
      # '';
    };
  };
}

