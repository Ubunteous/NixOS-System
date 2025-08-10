{ config, lib, ... }:

with lib;
let
  cfg = config.home.godot;
  homecfg = config.home;
in {
  options.home.godot = {
    enable = mkEnableOption "Enable support for godot menu entry";
  };

  config = mkIf (homecfg.enable && cfg.enable) {
    xdg.desktopEntries = {
      godot = {
        name = "Godot - Alter";
        genericName = "Godot - Alter";
        exec =
          "godot --editor --path ${config.home.homeDirectory}/Desktop/Alter";
        icon = "${config.home.homeDirectory}/.nix.d/files/icons/Godot.svg";
        terminal = false;
        type = "Application";
      };
    };
  };
}
