{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.languages.godot;
  langcfg = config.languages;
in {
  options.languages.godot = {
    enable =
      mkEnableOption "Enables support for the Gdscript programming language";
  };

  config = mkIf (langcfg.enable && cfg.enable) {
    users.users.${user} = { packages = with pkgs; [ godot_4 gdtoolkit_4 ]; };
  };
}
