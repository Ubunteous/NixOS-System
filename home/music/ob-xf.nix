{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.home.music.ob-xf;
  homecfg = config.home;
in
  {
	options.home.music.ob-xf = {
      enable = mkEnableOption "Enable support for the ob-xf plugin";
	};

	config = mkIf (homecfg.enable && cfg.enable) {
    home.packages = [ (pkgs.callPackage ../../pkgs/ob-xf/ob-xf.nix { }) ];
  };
}
