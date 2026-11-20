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
    home.packages = [ zebra-legacy ];
    home.file = {
      # zebra 2
      ".u-he/Zebra2" = {
        source = "${zebra-legacy}/lib/Zebra2";
        recursive = true;
      };

      ".clap/u-he/Zebra2.64.clap".source = "${zebra-legacy}/lib/Zebra2/Zebra2.64.so";

      # dark zebra
      ".u-he/ZebraHZ" = {
        source = "${zebra-legacy}/lib/ZebraHZ/";
        recursive = true;
      };

      ".clap/u-he/ZebraHZ.64.clap".source = "${zebra-legacy}/lib/ZebraHZ/ZebraHZ.64.so";

      # TODO: soundsets
    };
  };
}
