{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.home.music.u-he-legacy;
  homecfg = config.home;

  zebra-legacy = (pkgs.callPackage ../../pkgs/u-he/zebra-legacy.nix { });
in
{
  options.home.music.u-he-legacy = {
    enable = mkEnableOption "Enable support for u-he Zebra legacy";
  };

  config = mkIf (homecfg.enable && cfg.enable) {
    # home.packages = [ zebra-legacy ]; # not needed and causes conflict on file install.sh

    home.file = {
      # # zebra 2
      # ".u-he/Zebra2" = {
      #   source = "${zebra-legacy}/lib/Zebra2";
      #   recursive = true;
      # };

      # ".u-he/${pluginName}/${pluginName}.64.so" = {
      # 	source = "${pluginPkg}/lib/${pluginName}/${pluginName}.64.so";
      # };

      ".u-he/Zebra2/Zebra2.64.so" = {
        source = "${zebra-legacy}/lib/Zebra2/dialog";
      };

      ".u-he/Zebra2/dialog" = {
        source = "${zebra-legacy}/lib/Zebra2/dialog";
      };

      ".u-he/Zebra2/dialog.64" = {
        source = "${zebra-legacy}/lib/Zebra2/dialog.64";
      };

      ".clap/u-he/Zebra2.64.clap".source = "${zebra-legacy}/lib/Zebra2/Zebra2.64.so";

      # # dark zebra
      # ".u-he/ZebraHZ" = {
      #   source = "${zebra-legacy}/lib/ZebraHZ/";
      #   recursive = true;
      # };

      ".u-he/Zebra2/ZebraHZ.64.so" = {
        source = "${zebra-legacy}/lib/ZebraHZ/dialog";
      };

      ".u-he/ZebraHZ/dialog" = {
        source = "${zebra-legacy}/lib/ZebraHZ/dialog";
      };

      ".u-he/ZebraHZ/dialog.64" = {
        source = "${zebra-legacy}/lib/ZebraHZ/dialog.64";
      };

      ".clap/u-he/ZebraHZ.64.clap".source = "${zebra-legacy}/lib/ZebraHZ/ZebraHZ.64.so";

      # # soundsets
      # ".u-he/Zebra Legacy Soundsets" = {
      #   source = "${zebra-legacy}/lib/Zebra Legacy Soundsets/";
      #   recursive = true;
      # };
    };
  };
}
