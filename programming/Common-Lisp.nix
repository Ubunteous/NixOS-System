{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.languages.common-lisp;
  langcfg = config.languages;
in {
  options.languages.common-lisp = {
    enable =
      mkEnableOption "Enables support for the Common Lisp programming language";
  };

  config = mkIf (langcfg.enable && cfg.enable) {
    users.users.${user} = {
      packages = with pkgs;
        [
          sbcl

          # lem is a new text editor written in common lisp
          # it is currently (3/2024) unavailable in nix
        ];
    };
  };
}
