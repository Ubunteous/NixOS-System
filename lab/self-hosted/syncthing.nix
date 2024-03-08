{ config, lib, user, ... }:

with lib;
let
  cfg = config.lab.syncthing;
  labcfg = config.lab;
in {

  options.lab.syncthing = {
    enable = mkEnableOption "Enables support for syncthing";

    # # stignore option
    # folders = mkOption {
    #   type = types.attrsOf (types.submodule ({ name, ... }: {
    #     freeformType = settingsFormat.type;
    #     options = {

    #       stignore = mkOption {
    #         type = types.lines;
    #         default = "";
    #         description = lib.mdDoc ''
    #           Files to ignore for sync.
    #         '';
    #       };
    #     };
    #   }));
    # };
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.syncthing = {
      enable = true;

      user = "${user}";
      group = "users";

      dataDir = "/home/${user}/Sync";

      # risky if set to "Sync" as this folder can overwrite data
      configDir = "/home/${user}/.config/syncthing";
      # configDir = config.services.syncthing.dataDir + "/.config/Sync";
      # databaseDir = config.services.syncthing.configDir;

      # defaults to true and deletes non-nix devices/folders
      # overrideFolders = false;
      # overrideDevices = false;

      # only use if one syncthing instance
      openDefaultPorts = true;

      ###############
      #   folders   #
      ###############

      settings.folders = {
        oad = {
          # SEND ONLY
          # needs the following stignore patterns:
          # !*.pdf
          # *

          # # add later if I make an option for stignore
          # let config = optionalString cfg.extraConfig);
          # stignore = "\n";

          enable = true;
          path = "~/Desktop/Latex/Oeuvres à Découvrir/output";
          label = "Oeuvres à Découvrir";
          # id = ""; # must be same on all devices
          devices = [ "droid" ]; # must be defined in settings.devices

          # copyOwnershipFromParent = false;

          # more options can be used with versioning.option
          # one of "external", "simple", "staggered", "trashcan"
          # versioning = { 
          #   type = "simple"; 
          #   params = { 
          #     keep = "10";
          #   }; 
          # };
        };
        alter = {
          # SEND ONLY
          # needs the following stignore patterns:
          # *~

          enable = true;
          path = "~/org/Alter";
          label = "Alter";
          devices = [ "droid" ];

          # versioning = { 
          #   type = "staggered"; 
          #   params = { 
          #     cleanInterval = "3600"; 
          #     maxAge = "15768000";
          #   };
          # };
        };
        org = {
          # SEND ONLY
          # needs the following stignore patterns:
          # Alter/*
          # !*.org
          # *

          enable = true;
          path = "~/org";
          label = "Org";
          devices = [ "droid" ];

          # versioning = { 
          #   type = "staggered"; 
          #   params = { 
          #     cleanInterval = "3600"; 
          #     maxAge = "15768000";
          #   };
          # };
        };
      };

      ###############
      #   devices   #
      ###############

      settings.devices."droid" = {
        name = "droid";
        id = "[REDACTED]";

        # autoAcceptFolders = false;
      };

      ###############
      #   options   #
      ###############

      settings.options = {
        urAccepted = -1;

        # relaysEnabled = true;
        # localAnnounceEnabled = true;

        # maxFolderConcurrency = null;
        # localAnnouncePort = null;
        # limitBandwidthInLan = null;
      };

      #############
      #   relay   #
      #############

      # relay = {
      #   enable = true;

      # # add to networking.firewall.allowedTCPPorts
      #   statusPort = 22070;
      #   port = 22067;

      #   statusListenAddress = ""; # ip "1.2.3.4"
      #   listenAddress = ""; # ip "1.2.3.4"

      #   providedBy = "me"; # provider (me) name
      #   pools = null;
      #   perSessionRateBps = null;
      #   globalRateBps = null;
      #   extraOptions = [];
      # };

      ############
      #   misc   #
      ############

      # systemService = false; # defaults to true
      # guiAddress = "127.0.0.1:8384";

      # all_proxy = "socks5://address.com:1234";
      # key = "/path/to/key.pem" # copied to configDir
      # cert = "/path/to/cert.pem" # copied to configDir
      # extraFlags = [ "--reset-deltas" ];
    };
  };
}
