{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.lab.tmux;
  labcfg = config.lab;
in
  {
	options.lab.tmux = {
      enable = mkEnableOption "Enables support Tmux";
	};

	config = mkIf (labcfg.enable && cfg.enable) {
    programs.tmux = {
      enable = true;

      clock24 = true;

      plugins = [
        pkgs.tmuxPlugins.tmux-which-key # tmux show-wk-menu-root
      ];
      # extraConfig = "";
      # extraConfigBeforePlugins = ""; # ran before plugins

      # package = pkgs.tmux;

      # terminal = "screen"; # $TERM
      # escapeTime = 500; # time in ms to wait after escape
      # keyMode = "emacs"; # or vi
      # withUtempter = true; # for who (current lab)
      # secureSocket = true; # safer
      # shortcut = "b"; # C-b as prefix
      # baseIndex = 0; # starting index for windows/panes
      # newSession = false; # prefer using existing session
      # historyLimit = 2000;
      # resizeAmount = 5; # nb lines/cols when resizing
      # reverseSplit = false; # reverse window split shortcuts
      # aggressiveResize = false; # resize to size of smallest session
      # customPaneNavigationAndResize = false; # override hjkl in vi mode
    };
  };
}
