{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.home.music.tx16wx;
  homecfg = config.home;

  tx16wx = (pkgs.callPackage ../../pkgs/tx16wx/tx16wx.nix { });
in
{
  options.home.music.tx16wx = {
    enable = mkEnableOption "Enable support for the tx16wx plugin";
  };

  config = mkIf (homecfg.enable && cfg.enable) {
    home.packages = [ tx16wx ];
  };
}
