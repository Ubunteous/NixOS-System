{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.home.music.reaimgui;
  homecfg = config.home;

  reaimgui = (pkgs.callPackage ../../pkgs/reaimgui/reaimgui.nix { });
in
{
  options.home.music.reaimgui = {
    enable = mkEnableOption "Enable support for the reaimgui binary";
  };

  config = mkIf (homecfg.enable && cfg.enable) {
    home.packages = [ reaimgui ];

    xdg.configFile."REAPER/UserPlugins/reaper_imgui-x86_64.so".source =
      "${reaimgui}/UserPlugins/reaper_imgui-x86_64.so";
  };
}
