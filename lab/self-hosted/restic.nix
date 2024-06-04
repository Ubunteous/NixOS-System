{ config, lib, user, ... }:

# ALTERNATIVES: BORG+BORGMATIC or KOPIA (not yet in nix)

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

        extraFlags = [ "--no-auth" ];
      };

      backups."name" = {
        user = "${user}"; # defaults to root

        # use either to provide repository to backup to
        # repositoryFile = null;
        # repository = "sftp:backup@192.168.1.100:/backups/name";

        # # paths and dynamicFilesFrom specify what should be backed up
        # # if empty, does not backup. only prunes
        # paths = [ "/var/lib/postgresql" "/home/user/backup" ];
        # dynamicFilesFrom = "find /home/${user}/git -type d -name .git"; # bash

        passwordFile = "/path/to/file";

        # # create the repo if does not exist
        # initialize = true;

        # # patterns to exclude during backup
        # exclude = [ "/var/cache" "/home/*/.cache" ".git" ];

        # environmentFile = "/path/to/file";
        # createWrapper = true;
        # backupPrepareCommand = "make command here";
        # backupCleanupCommand = "make command here";

        ###############
        #   options   #
        ###############

        # # if not specified, backups must be done manually
        # timerConfig = {
        #   OnCalendar = "daily";
        #   Persistent = true;
        # };

        # note: forget command is run after backup command
        # pruneOpts = [
        #   "--keep-daily 7"
        #   "--keep-weekly 5"
        #   "--keep-monthly 12"
        #   "--keep-yearly 75"
        # ];

        # extraOptions = [];
        # extraBackupArgs = [];
        # checkOpts = [ "--with-cache" ];

        ##############
        #   rclone   #
        ##############

        # rcloneOptions = {
        #   bwlimit = "10M";
        #   drive-use-trash = "true";
        # };
        # rcloneConfigFile = "/path/to/file"
        # rcloneConfig = {};

        ############
        #   misc   #
        ############

        # prometheus = true;
        # privateRepos = true;
        # listenAddress = 8000; # defaults to 8000

        # dataDir = "/var/lib/restic";
        # appendOnly = true;

      };
    };
  };
}
