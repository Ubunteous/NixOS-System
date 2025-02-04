{ config, lib, ... }:

with lib;
let
  cfg = config.lab.deluge;
  labcfg = config.lab;
in {
  options.lab.deluge = {
    enable = mkEnableOption "Enables support for Deluge";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    ##################
    #       DELUGE       #
    ##################

    services.deluge = {
      enable = true;
      web = {
        enable = true;
        openFirewall = true;
      };

      ##################
      # DECLARATIVE CONFIG #
      ##################

      # if true, you can use options config/openFirewall/authFile
      # declarative = true;
      # openFirewall = true;

      # see https://git.deluge-torrent.org/deluge/tree/deluge/core/preferencesmanager.py#n41
      # config = {
      #   download_location = "/srv/torrents/";
      #   max_upload_speed = "1000.0";
      #   share_ratio_limit = "2.0";
      #   allow_remote = true;
      #   daemon_port = 58846;
      #   listen_ports = [ 6881 6889 ];
      # };

      # authFile = "/run/keys/deluge-auth"; # See https://dev.deluge-torrent.org/wiki/UserGuide/Authentication

      ##########
      # DEFAULTS #
      ##########

      # web.port = 8112;
      # package = pkgs.deluge; # pkgs.deluge-gtk;
      # group = "deluge";
      # user = "deluge";
      # openFilesLimit = 4096;
      # dataDir + "/var/lib/deluge";
      # extraPackages = [];
    };
  };
}
