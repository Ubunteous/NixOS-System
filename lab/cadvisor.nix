{ config, lib, ... }:

with lib;
let
  cfg = config.lab.cadvisor;
  labcfg = config.lab;
in {

  options.lab.cadvisor = {
    enable = mkEnableOption "Enables support for cadvisor";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.cadvisor = {
      enable = true;

      # port = 8080; defaults to 8080
      # listenAddress = "127.0.0.1";

      # extraOptions = [];

      ############
      # DEFAULTS #
      ############

      # storageDriver = null; # could be "influxdb"

      # storageDriverUser = "root";
      # storageDriverHost = "localhost:8086";
      # storageDriverSecure = false; # secure communications
      # storageDriverDb = "root";

      # storageDriverPasswordFile = "path/to/file";
      # storageDriverPassword = "root"; # risky. prefer file
    };
  };
}
