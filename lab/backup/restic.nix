{ config, lib, user, ... }:

with lib;
let
  cfg = config.lab.restic;
  labcfg = config.lab;
in {
  options.lab.restic = {
    enable = mkEnableOption "Enables support for restic";
  };

  # manually create repo on server
  # mkdir /var/lib/restic/
  # chmod 777 /var/lib/restic
  # chmod 777 ~/path/to/password/file # on client for password

  # # init repo from client
  # => not necessary. nix does it if /var/lib/restic exists
  # nix-shell -p restic
  # restic -r sftp:nix@server:/var/lib/restic init

  config = mkIf (labcfg.enable && cfg.enable) {
    services.restic = {
      server = {
        enable = true;
        extraFlags = [ "--no-auth" ];

        # prometheus = false;
        # privateRepos = false;
        # listenAddress = 8000; # defaults to 8000
        # dataDir = "/var/lib/restic";
        # appendOnly = false;
      };

      backups."name" = {
        # important: the following user's ssh key is used
        user = "${user}"; # defaults to root

        # use either to provide repository to backup to
        # repositoryFile = null;
        # setup with restic -r sftp:nix@server:/var/lib/restic init
        repository = "sftp:nix@server:/var/lib/restic/"; # ssh
        # repository = "local:/var/lib/restic/"; # on same device

        # paths and dynamicFilesFrom specify what should be backed up
        # if empty, does not backup. only prunes
        paths = [ "/home/${user}/Videos/" ];
        # dynamicFilesFrom = "find /home/${user}/git -type d -name .git"; # bash

        passwordFile = "/home/${user}/.nix.d/files/restic";
        # passwordFile = "/etc/nixos/restic"; # restic

        # create the repo if does not exist
        initialize = true;

        # # patterns to exclude during backup
        # exclude = [ "/var/cache" "/home/*/.cache" ".git" ];

        # environmentFile = "/path/to/file";
        # createWrapper = true;
        # backupPrepareCommand = "make command here";
        # backupCleanupCommand = "make command here";

        ###############
        #     options    #
        ###############

        # # if not specified, backups must be done manually
        timerConfig = {
          OnCalendar = "minutely"; # "saturday 23:00"
          # OnCalendar = "daily";
          # OnCalendar = "00:05";
          Persistent = true;
        };

        # note: forget command is run after backup command
        pruneOpts = [
          # "--keep-daily 7"
          # "--keep-weekly 5"
          "--keep-monthly 10"
          "--keep-yearly 50"
        ];

        # extraOptions = [];
        # checkOpts = [ "--with-cache" ];
        # extraBackupArgs = []; # [ "--exclude-file=/etc/nixos/restic-ignore" ];

        ##############
        #    rclone     #
        ##############

        # rcloneOptions = {
        #   bwlimit = "10M";
        #   drive-use-trash = "true";
        # };
        # rcloneConfigFile = "/path/to/file"
        # rcloneConfig = {};
      };
    };
  };
}
