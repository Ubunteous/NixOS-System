{ config, lib, user, ... }:

with lib;
let
  cfg = config.lab.borg;
  labcfg = config.lab;
in {

  options.lab.borg = { enable = mkEnableOption "Enables support for borg"; };

  # monitor with:
  # journalctl -fu borgbackup-job-borgbase.service

  # restore with:
  # mkdir mount
  # borg-job-borgbase mount o6h6zl22@o6h6zl22.repo.borgbase.com:repo ./mount
  # borg-job-borgbase umount /root/borgbase/mount # when done

  config = mkIf (labcfg.enable && cfg.enable) {
    services.borgbackup = {
      # repos.name = { # server side
      #   # use one ssh key per repository
      #   authorizedKeys = [ ];
      #   # authorizedKeysAppendOnly = [];

      #   # where backups are stored. dir auto created if needed
      #   # path = "/var/lib/borgbackup";

      #   #########
      #   # DEFAULT #
      #   #########

      #   # allowSubRepos = false;
      #   # quota = "100G"; # per sub repo

      #   # user = "borg";
      #   # group = "borg";
      # };

      jobs.name = { # client side
        # set to false is sending to an external drive not always mounted
        # doInit = false;
        # removableDevice = true; # is repo external device

        paths = "/home/${user}/Videos/local"; # paths to backup
        # environment = {}; # { BORG_RSH = "ssh -i /path/to/key"; }

        startAt = "minutely"; # "daily"; # see systemd.time(7)

        # repository to back up to
        # "user@machine:/path/to/repo";
        repo = "${user}@localhost:/home/${user}/Videos/remote";
        # repo = # repository not valid => "/home/${user}/Videos/remote";

        # + include / - exclude. firsts paths get priority
        # patterns = [ "+ /home/${user}" "- /home/*" ];
        # exclude = []; # [ "/home/*/.cache" "/nix" ] # exclude path

        # remove all archives which do not match specification
        prune = {
          keep = {
            within = "1w"; # Keep all archives from the last week
            daily = 7;
            weekly = 4;
            monthly = -1; # Keep at least one archive for each month
          };
          # prefix = cfg.archiveBaseName; # use null or "" to consider all archives
        };

        # trigger backup if schedule missed
        persistentTimer = true;

        archiveBaseName = "nix-bkp"; # "${config.networking.hostName}-<name>";

        encryption = {
          mode = "none";

          # one of "repokey", "keyfile", "repokey-blake2",
          # "keyfile-blake2", "authenticated", "authenticated-blake2", "none"
          # passCommand = null; # "cat /path/to/passphrase_file"

          # passphrase = null;
        };

        #############
        #    DEFAULT   #
        #############

        # by default, borg only has access to ~/.config/borg and ~/.cache/borg
        # readWritePaths = []; # [ "/var/backup/mysqldump" ];

        # failOnWarnings = true;

        # prevent system from sleeping during backup
        # inhibitsSleep = false;

        # extraArgs = []; # [ "--remote-path=/path/to/borg" ]
        # extraCompactArgs = []; # [ "--cleanup-commits" ]
        # extraCreateArgs = []; # [ "--stats" "--checkpoint-interval 600" ]
        # extraInitArgs = []; # [ "--append-only" ]
        # extraPruneArgs = []; # [ "--save-space" ]

        # compression = "lz4"; # "auto,lzma"
        # dateFormat = "+%Y-%m-%dT%H:%M:%S";

        # privateTmp = true;

        # user = "root";
        # group = "root";

        # dumpCommand = null; "/path/to/createZFSsend.sh"

        # SHELL TRIGGERS
        # These shell commands are all ran after an event

        # borg create
        # postCreate = "";

        # borg init
        # postHook = "";
        # postInit = "";

        # borg backup
        # postPrune = "";
        # preHook = "";
      };
    };

    # services.borgmatic = {
    #   enable = false;

    #   settings = {
    #     # dir/files to backup
    #     # source_directories = [ "/home" ];

    #     # repositories = [
    #     #   # {
    #     #   #   label = "backupserver";
    #     #   #   path = "ssh://user@backupserver/./sourcehostname.borg";
    #     #   # }
    #     #   {
    #     #     label = "local";
    #     #     path = "/mnt/backup";
    #     #   }
    #     # ];
    #   };
    #   configurations.name = {
    #     source_directories = [ "/home" ];

    #     repositories = [
    #       {
    #         label = "backupserver";
    #         path = "ssh://user@backupserver/./sourcehostname.borg";
    #       }
    #       {
    #         label = "local";
    #         path = "/mnt/backup";
    #       }
    #     ];
    #   };

    #   # enableConfigCheck = true;
    # };
  };
}
