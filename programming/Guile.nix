{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.languages.c;
  langcfg = config.languages;
in {
  options.languages.guile = {
    enable =
      mkEnableOption "Enables support for the Guile programming language";
  };

  config = mkIf (langcfg.enable && cfg.enable) {
    users.users.${user} = { packages = with pkgs; [ guile ]; };
  };
}
