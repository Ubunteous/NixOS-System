{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.languages.lua;
  langcfg = config.languages;
in {
  options.languages.lua = {
    enable = mkEnableOption "Enables support for the Lua programming language";
  };

  config = mkIf (langcfg.enable && cfg.enable) {
    users.users.${user} = {
      packages = with pkgs; [
        lua # v5.2 as of 2024
        # luajit # no release beyond 5.1

        stylua
        lua52Packages.luacheck
        lua52Packages.busted # tests

        lua-language-server
      ];
    };
  };
}
