{ config, lib, ... }:

with lib;
let
  cfg = config.lab.resilio;
  labcfg = config.lab;
in {

  options.lab.resilio = {
    enable = mkEnableOption "Enables support for resilio";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.resilio = {
      enable = true;

      # deviceName = "Name"; # defaults to config.networking.hostName

      # sharedFolders = [
      # 	{
      # 	  directory = "/home/user/sync_test";
      # 	  knownHosts = [
      # 	    "192.168.1.2:4444"
      # 	    "192.168.1.3:4444"
      # 	  ];
      # 	  searchLAN = true;
      # 	  secretFile = "/run/resilio-secret";
      # 	  useDHT = false;
      # 	  useRelayServer = true;
      # 	  useSyncTrash = true;
      # 	  useTracker = true;
      # 	}
      # ];

      ###############
      #   ADDRESS   #
      ###############

      # listeningPort = 0; # 0 randomizes the port
      # httpListenPort = 9000;
      # httpListenAddr = "[::1]"; # can be an ip

      ##############
      #   WEB UI   #
      ##############

      # directoryRoot = ""; # where web UI add folders
      # web login username and password
      # httpLogin = ""; # username
      # httpPass = ""; # password
      # enableWebUI = false; # don't use if sharedFolders != []

      ###############
      #   DEFAULT   #
      ###############

      # checkForUpdates = true;
      # encryptLAN = true;
      # apiKey = "";
      # useUpnp = true; # Universal Plug-n-Play
      # storagePath = "/var/lib/resilio-sync/";

      # 0 is unlimited
      # downloadLimit = 0;
      # uploadLimit = 0;
    };
  };
}
