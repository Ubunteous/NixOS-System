{ config, lib, ... }:

with lib;
let
  cfg = config.lab.kodi;
  labcfg = config.lab;
  in {

    options.lab.kodi = { enable = mkEnableOption "Enables support for kodi"; };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.xserver.desktopManager.kodi = {
      enable = true;

      # package = kodi.withPackages (p: with p; [ jellyfin pvr-iptvsimple vfs-sftp ])
    };
  };
}
