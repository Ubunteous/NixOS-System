{ config, lib, ... }:

with lib;
let
  cfg = config.lab.rtorrent;
  labcfg = config.lab;
in {
  options.lab.rtorrent = {
    enable = mkEnableOption "Enables support for rtorrent";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    ########################
    #       RTORRENT       #
    ########################

    services.rtorrent = {
      enable = true;
      openFirewall = true;

      # recommanded default templated prepended
      # https://rtorrent-docs.readthedocs.io/en/latest/cookbook.html#modernized-configuration-template
      # configText = ""; # rtorrent.rc

      ###########
      # DEFAULT #
      ###########

      # dataDir = "/var/lib/rtorrent";
      # downloadDir = "${config.services.rtorrent.dataDir}/download";

      # port = 50000;
      # package = pkgs.rtorrent;
      # group = "rtorrent";
      # dataPermissions = "0750"; # "0755"
      # user = "rtorrent";
      # rpcSocket = "/run/rtorrent/rpc.sock";
    };
  };
}
