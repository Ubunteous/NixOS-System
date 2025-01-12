{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.languages.scss;
  langcfg = config.languages;
in {
  options.languages.scss = {
    enable = mkEnableOption "Enables support for the SCSS language";
  };

  config = mkIf (langcfg.enable && cfg.enable) {
    users.users.${user} = {
      packages = with pkgs;
        [
          sass
          # scss-lint
          # htmx-lsp
        ];
    };
  };
}
