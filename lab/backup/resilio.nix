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

      # deviceName
      # useUpnp
      # uploadLimit
      # storagePath
      # sharedFolders
      # listeningPort
      # httpPass
      # httpLogin
      # httpListenPort
      # httpListenAddr
      # encryptLAN
      # enableWebUI
      # downloadLimit
      # directoryRoot
      # checkForUpdates
      # apiKey
    };
  };
}
