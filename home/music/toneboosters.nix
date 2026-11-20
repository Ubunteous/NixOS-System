{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.home.music.toneboosters;
  homecfg = config.home;

  plugins = map (plugin: pkgs.callPackage ../../pkgs/toneboosters/toneboosters.nix plugin) (
    (attrValues (import ../../pkgs/toneboosters/plugins.nix))
  );
in
  {
	options.home.music.toneboosters = {
      enable = mkEnableOption "Enable support for toneboosters plugins";
	};

	config = mkIf (homecfg.enable && cfg.enable) {
    home.packages = plugins;
  };
}
