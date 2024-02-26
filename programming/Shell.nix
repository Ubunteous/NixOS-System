{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.languages.shell;
  langcfg = config.languages;
  in
  {
    options.languages.shell = {
      enable = mkEnableOption "Enables support for shell utililities";
    };

    config = mkIf (langcfg.enable && cfg.enable) {
      users.users.${user} = {
	packages = with pkgs; [
	  nodePackages.bash-language-server

	  shellcheck
	  shfmt # format
	];
      };
    };
  }
