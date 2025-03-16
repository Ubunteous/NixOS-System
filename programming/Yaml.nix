{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.languages.yaml;
  langcfg = config.languages;
in {
  options.languages.yaml = {
    enable = mkEnableOption "Enables support for the YAML language";
  };

  config = mkIf (langcfg.enable && cfg.enable) {
    users.users.${user} = {
      packages = with pkgs; [ yamlfmt yamllint yaml-language-server ];
    };
  };
}
