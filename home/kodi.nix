{ config, lib, ... }:

with lib;
let
  cfg = config.home.kodi;
  homecfg = config.home;
in {
  options.home.kodi = { enable = mkEnableOption "Enables support for kodi"; };

  config = mkIf (homecfg.enable && cfg.enable) {
    ############
    #   KODI   #
    ############

    programs.kodi = {
      enable = true;

      sources = {
        video = {
          default = "Videos";
          source = [{
            name = "Videos";
            path = "${config.home.homeDirectory}/Videos";
            allowsharing = "false";
          }];
        };
      };

      # defaults to "${config.home.homeDirectory}/kodi";
      datadir = "${config.home.homeDirectory}/.config/kodi";

      # settings = { videolibrary.showemptytvshows = "true"; };
      # package = pkgs.kodi.withPackages (exts: [ exts.pvr-iptvsimple ]);
    };
  };
}

# regular nixos config
#     config = mkIf (labcfg.enable && cfg.enable) {
#     services.xserver.desktopManager.kodi = {
#       enable = true;

#       # package = kodi.withPackages (p: with p; [ jellyfin pvr-iptvsimple vfs-sftp ])
#     };
#   };
# }
