{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.home.music.tdr;
  homecfg = config.home;

  plugins = map (plugin: pkgs.callPackage ../../pkgs/TDR/tdr.nix plugin) (
    (attrValues (import ../../pkgs/TDR/plugins.nix))
  );
in
  {
	options.home.music.tdr = {
      enable = mkEnableOption "Enable support for tdr plugins";
	};

	config = mkIf (homecfg.enable && cfg.enable) {
    home.packages = plugins;
  };
}
