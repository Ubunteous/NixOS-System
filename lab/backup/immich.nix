{ config, lib, ... }:

with lib;
let
  cfg = config.lab.immich;
  labcfg = config.lab;
in {

  options.lab.immich = {
    enable = mkEnableOption "Enables support for Immich";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.immich = {
      enable = true;

      environment = { IMMICH_LOG_LEVEL = "verbose"; };

      # machine-learning = {
      #   enable = true;
      #   environment = { MACHINE_LEARNING_MODEL_TTL = "600"; };
      # };

      ###########
      # DEFAULT #
      ###########

      # redis = {
      # 	enable = true;
      # 	port = 0; # disables tcp
      # 	host = config.services.redis.servers.immich.unixSocket;
      # };

      # database = {
      # 	enable = true;
      # 	name = "immich";
      # 	user = "immich";
      # 	createDB = true;
      # 	port = 5432;
      # 	host = "/run/postgresql"; # ex: "127.0.0.1"
      # };

      # ports = 3001;
      # host = "localhost";
      # user = "immich";
      # group = "immich";
      # openFirewall = false;

      # mediaLocation = "/var/lib/immich";
      # secretsFile = null; # example: "/run/secrets/immich"
    };
  };
}
