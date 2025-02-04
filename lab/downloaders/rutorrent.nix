{ config, lib, ... }:

with lib;
let
  cfg = config.lab.rutorrent;
  labcfg = config.lab;
in {
  options.lab.rutorrent = {
    enable = mkEnableOption "Enables support for rutorrent";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    ######################
    #       DELUGE       #
    ######################

    services.rutorrent = {
      enable = true;

      # # php-fpm.conf
      # poolSettings = {
      #   pm = "dynamic";
      #   "pm.max_children" = 32;
      #   "pm.max_requests" = 500;
      #   "pm.max_spare_servers" = 4;
      #   "pm.min_spare_servers" = 2;
      #   "pm.start_servers" = 2;
      # };

      # # [ "httprpc" "data" "diskspace" "edit" "erasedata" "theme" "trafic" ]
      # plugins = [ "httprpc" ];

      ###########
      # DEFAULT #
      ###########

      dataDir = "/var/lib/rutorrent";
      # hostName = "?" # doc strange. probably wrong

      rpcSocket = config.services.rtorrent.rpcSocket;

      user = "rutorrent";
      group = "rutorrent";
    };
  };
}
