{ config, lib, ... }:

with lib;
let
  cfg = config.lab.restic;
  labcfg = config.lab;
in {

  options.lab.restic = {
    enable = mkEnableOption "Enables support for restic";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.restic = {
      server = {
        enable = true;

        # prometheus = true;
        # privateRepos = true;
        # listenAddress = 8000; # defaults to 8000
        extraFlags = [ "--no-auth" ];
        # dataDir = "/var/lib/restic";
        # appendOnly = true;
      };

      backups."name" = {
        # user = "root";

        # timerConfig = {
        #   OnCalendar = "daily";
        #   Persistent = true;
        # };

        # use either
        repositoryFile = "/path/to/file";
        # repository = "sftp:backup@192.168.1.100:/backups/name";

        # rcloneOptions = {
        #   bwlimit = "10M";
        #   drive-use-trash = "true";
        # };
        # rcloneConfigFile = "/path/to/file"
        # rcloneConfig = {};

        # pruneOpts = [];
        # paths = [];
        passwordFile = "/path/to/file";

        # initialize = true;
        # extraOptions = [];
        # extraBackupArgs = [];
        # exclude = [];
        # environmentFile = "/path/to/file";
        # dynamicFilesFrom = "make a script here";
        # createWrapper = true;
        # checkOpts = [ "--with-cache" ];
        # backupPrepareCommand = "make command here";
        # backupCleanupCommand = "make command here";
      };
    };
  };
}
