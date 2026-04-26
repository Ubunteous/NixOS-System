{ config, lib, ... }:

with lib;
let
  cfg = config.home.gallery-dl;
  homecfg = config.home;
in {
  options.home.gallery-dl = {
    enable = mkEnableOption "Enable support for gallery-dl";
  };

  config = mkIf (homecfg.enable && cfg.enable) {
    ###########
    #   EWW   #
    ###########

    programs.gallery-dl = {
      enable = true;
      # package = pkgs.gallery-dl;
      settings = { extractor.base-directory = "~/Downloads/gallery/"; };
    };
  };
}
