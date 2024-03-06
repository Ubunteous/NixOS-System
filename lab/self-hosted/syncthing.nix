{ config, lib, ... }:

with lib;
let
  cfg = config.lab.syncthing;
  labcfg = config.lab;
in {

  options.lab.syncthing = {
    enable = mkEnableOption "Enables support for syncthing";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.syncthing = {
      enable = true;

      # group = "syncthing";
      # user = "syncthing";
      # systemService = true; # defaults to true

      # extraFlags = [ "--reset-deltas" ];
      # all_proxy

      # key
      # cert

      # only use if one syncthing instance
      openDefaultPorts = true;

      # relay = {
      #   enable = true;
      #   statusPort
      #   statusListenAddress
      #   providedBy
      #   port
      #   pools
      #   perSessionRateBps
      #   listenAddress
      #   globalRateBps
      #   extraOptions
      # };

      # overrideFolders
      # overrideDevices
      # guiAddress
      # databaseDir
      # dataDir
      # configDir

      ################
      #   settings   #
      ################

      # settings = {
      #   folders.<name> = {
      #     enable = true;
      #     copyOwnershipFromParent
      #     versioning.type
      #     path
      #     label
      #     id
      #     devices
      #   };

      #   devices.<name> = {
      #     autoAcceptFolders
      #     name
      #     id
      #   };

      #   options = {
      #     urAccepted
      #     relaysEnabled
      #     maxFolderConcurrency
      #     localAnnouncePort
      #     localAnnounceEnabled
      #     limitBandwidthInLan
      #   };
    };
  };
}
