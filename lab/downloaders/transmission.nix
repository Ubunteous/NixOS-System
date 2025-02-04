{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.lab.transmission;
  labcfg = config.lab;
in {
  options.lab.transmission = {
    enable = mkEnableOption "Enables support for Transmission";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    ######################
    #       DELUGE       #
    ######################

    services.transmission = {
      enable = true;

      openFirewall = true;
      openPeerPorts = true;
      openRPCPort = true;

      # home = "/var/lib/transmission";
      package = pkgs.transmission_4-gtk; # 3/or qt
      downloadDirPermissions = "770"; # null
      # webHome = pkgs.flood-for-transmission;

      settings = {
        # rpc-port = 9091;
        rpc-bind-address = "0.0.0.0";

        # "${config.services.transmission.home}/Downloads";
        download-dir = "/var/servarr/torrent";

        # watch-dir-enabled 
        # watch-dir
        # incomplete-dir-enabled
        # incomplete-dir

        # utp-enabled
        # umask
        # trash-original-torrent-files
        # script-torrent-done-filename
        # script-torrent-done-enabled

        # peer-port = 51413;
        # peer-port-random-on-start
        # peer-port-random-low
        # peer-port-random-high
        # message-level
      };

      ###########
      # DEFAULT #
      ###########

      # user = "transmission";
      # group = "transmission";

      # performanceNetParameters = false;
      # extraFlags = [];
      # credentialsFile = "/dev/null";
    };
  };
}
