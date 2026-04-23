{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.languages.sqlite;
  langcfg = config.languages;
in {
  options.languages.sqlite = {
    enable =
      mkEnableOption "Enables support for the SQLite programming language";
  };

  config = mkIf (langcfg.enable && cfg.enable) {
    users.users.${user} = { packages = with pkgs; [ sqlite ]; };
  };
}
