{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.home.music.auburn;
  homecfg = config.home;

  plugins = map (plugin: pkgs.callPackage ../../pkgs/Auburn-Sounds/auburn-sounds.nix plugin) (
    (attrValues (import ../../pkgs/Auburn-Sounds/plugins.nix))
  );
in
  {
	options.home.music.auburn = {
      enable = mkEnableOption "Enable support for auburn plugins";
	};

	config = mkIf (homecfg.enable && cfg.enable) {
    home.packages = plugins;
  };
}
