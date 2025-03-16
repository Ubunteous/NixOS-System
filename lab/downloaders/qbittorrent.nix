{ config, lib, pkgs, ... }:

with lib;

let
  mycfg = config.lab.qbittorrent-nox;
  labcfg = config.lab;

  older-qBitTorrent = pkgs.qbittorrent-nox.overrideAttrs (old: {
    version = "5.0.1";
    src = pkgs.fetchFromGitHub {
	  owner = "qbittorrent";
      repo = "qBittorrent";
      rev = "release-${version}";
      hash = "sha256-BmfTQGftQIkRrlSpJy0yHTh0r3D2CWLIo+tnL0+OeA4=";
    };
  });
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

      package = pkgs.stable.qbittorrent-nox; # defaults to nox
      # create webhome like transmission for vuetorrent

      # dataDir = "/var/lib/qbittorrent";
      # user = "qbittorrent";
      # group = "qbittorrent";
    };
  };
}
