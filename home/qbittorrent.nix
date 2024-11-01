{ config, lib, ... }:

with lib;
let
  cfg = config.home.qbittorrent;
  homecfg = config.home;
  in {
    imports = [ ./modules/qbittorrent.nix ];

    options.home.qbittorrent = {
    enable = mkEnableOption "Enable support for qBittorrent";
  };

  config = mkIf (homecfg.enable && cfg.enable) {
    programs.qbittorrent = { enable = true; };
  };
}
