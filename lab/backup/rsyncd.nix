{ config, lib, user, ... }:

with lib;
let
  cfg = config.lab.rsyncd;
  labcfg = config.lab;
in {

  options.lab.rsyncd = { enable = mkEnableOption "Enables support for rsync"; };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.rsyncd = {
      enable = true;

      # settings = {
      #   cvs = {
      #     "auth users" = [ "tridge" "susan" ];
      #     comment = "CVS repository (requires authentication)";
      #     path = "/data/cvs";
      #     "secrets file" = "/etc/rsyncd.secrets";
      #   };
      #   ftp = {
      #     comment = "whole ftp area";
      #     path = "/var/ftp/./pub";
      #   };
      #   global = {
      #     gid = "nobody";
      #     "max connections" = 4;
      #     uid = "nobody";
      #     "use chroot" = true;
      #   };
      # };

      # port = 873;
      # socketActivated = false;
    };
  };
}
