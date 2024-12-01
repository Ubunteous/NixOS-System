{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.home.emacs;
  homecfg = config.home;
in {
  options.home.emacs = { enable = mkEnableOption "Enable support for Emacs"; };

  config = mkIf (homecfg.enable && cfg.enable) {
    #############
    #   EMACS   #
    #############

    # services.emacs.enable = true; # daemon
    programs.emacs = {
      enable = true;

      extraPackages = epkgs: [
        epkgs.vterm

        # mu does not install mu4e automatically anymore
        # pkgs.mu
        # epkgs.mu4e

        epkgs.jinx
        # epkgs.tree-sitter-langs
        # treesit-grammars.with-all-grammars
        epkgs.treesit-grammars.with-all-grammars

        epkgs.auctex
      ];
    };
  };
}
