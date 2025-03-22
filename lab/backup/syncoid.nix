{ config, lib, ... }:

with lib;
let
  cfg = config.lab.syncoid;
  labcfg = config.lab;
in {

  options.lab.syncoid = {
    enable = mkEnableOption "Enables support for syncoid";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.syncoid = {
      enable = true;

      # commonArgs = []; # "--no-sync-snap"
      # interval = "hourly";

      # systemd config common to all syncoid services
      # service = {};

      # sshKey = null; # command, string or path

      # see doc for permissions
      # localTargetAllow = []; #  "compress" "create"
      # localSourceAllow = []; # "send", "mount"...

      # user = "syncoid";
      # package = pkgs.syncoid;
      # group = "syncoid";

      commands."name" = {
        # target = null; # "user@server:pool/dataset"
        # source = null; # "pool/dataset"
        # sshKey = "";

        # specified without leading dash, separate by space
        # sendOptions = "";
        # recvOptions = "";

        # localTargetAllow = [];
        # localSourceAllow = [];
        # service = {};
        # useCommonArgs = true;
        # extraArgs = []; # "--sshport 2222"
        # recursive = false;
      };
    };
  };
}
