{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.home.music.madrona;
  homecfg = config.home;

  aalto = (pkgs.callPackage ../../pkgs/madrona/aalto.nix { });
in
{
  options.home.music.madrona = {
    enable = mkEnableOption "Enable support for aalto";
  };

  config = mkIf (homecfg.enable && cfg.enable) {
    home.packages = [ aalto ];

    home.file.".local/share/Madrona Labs/" = {
      source = "${aalto}/lib/extra/Patches";
      # recursive = true;
    };
  };
}
