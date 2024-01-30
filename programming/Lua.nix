{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.languages.lua;
  langcfg = config.languages;
in
{
  options.languages.lua = {
    enable = mkEnableOption "Enables support for the Lua programming languages";
  };

  config = mkIf (langcfg.enable && cfg.enable) {
    users.users.${user} = {
      packages = with pkgs; [
        lua
        # luajit
      ];
    };
  };
}
