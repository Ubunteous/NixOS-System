{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.languages.typst;
  langcfg = config.languages;
in {
  options.languages.typst = {
    enable =
      mkEnableOption "Enables support for the Typst programming languages";
  };

  config = mkIf (langcfg.enable && cfg.enable) {
    users.users.${user} = {
      packages = with pkgs; [
        typst

        typst-preview

        typstfmt
        # typstyle # not available yet. maybe update unstable

        typst-lsp

        # libgccjit # for typst-ts-mode
      ];
    };
  };
}
