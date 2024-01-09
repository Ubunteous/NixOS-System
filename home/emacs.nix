{ config, lib, pkgs, home-manager, user, ... }:

with lib;
let
  cfg = config.home.emacs;
in
{
  options.home.emacs = {
    enable = mkEnableOption "Enable support for Emacs";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user} = {
      #############
      #   EMACS   #
      #############

      programs.emacs = {
        enable = true;
        extraPackages = epkgs: [ epkgs.vterm ];
      };
    };
  };
}
