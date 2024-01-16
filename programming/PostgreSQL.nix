{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.languages.postgresql;
  langcfg = config.languages;
in
{
  options.languages.postgresql = {
    enable = mkEnableOption "Enables support for the PostgreSQL programming languages";
  };

  config = mkIf (langcfg.enable && cfg.enable) {
    users.users.${user} = {
      packages = with pkgs; [
        postgresql
      ];
    };
  };
}
