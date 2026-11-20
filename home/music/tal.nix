{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.home.music.tal;
  homecfg = config.home;

  plugins = map (plugin: pkgs.callPackage ../../pkgs/TAL/tal.nix plugin) (
    (attrValues (import ../../pkgs/TAL/plugins.nix))
  );
in
  {
	options.home.music.tal = {
      enable = mkEnableOption "Enable support for tal plugins";
	};

	config = mkIf (homecfg.enable && cfg.enable) {
    home.packages = plugins;
  };
}
