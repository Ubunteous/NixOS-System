{ config, lib, pkgs, ... }:

with lib;

let
  mycfg = config.lab.qbittorrent-nox;
  labcfg = config.lab;
in {
  imports = [ ../../modules/qbittorrent.nix ];

  options.lab.qbittorrent-nox = {
    enable = mkEnableOption "Enable support for qBittorrent-nox";
  };

  config = mkIf (labcfg.enable && mycfg.enable) {
    services.qbittorrent-nox = {
      enable = true;
      openFirewall = true;

      # port = 8080;

      # package = pkgs.qbittorrent; # defaults to nox
      # create webhome like transmission for vuetorrent

      # dataDir = "/var/lib/qbittorrent";
      # user = "qbittorrent";
      # group = "qbittorrent";
    };
  };
}
