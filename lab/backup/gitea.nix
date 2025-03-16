{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.lab.git;
  labcfg = config.lab;
in {

  options.lab.gitea = { enable = mkEnableOption "Enables support for gitea"; };

  config = mkIf (labcfg.enable && cfg.enable && cfg.webUI == "gitea") {
    users.users.${user}.packages = [ pkgs.tea ];

	networking.firewall.allowedTCPPorts = [ 3000 ];

    services.gitea = {
      enable = true;

      repositoryRoot = cfg.repoDir;
      # repositoryRoot = "${config.services.gitea.stateDir}/repositories";
      # stateDir = "/var/lib/gitea";
      # customDir = "${config.services.gitea.stateDir}/custom";

      ########
      # DUMP #
      ########

      dump = {
        enable = false;

        # "zip", "rar", "tar", "sz", "tar.gz", "tar.xz", "tar.bz2", "tar.br", "tar.lz4", "tar.zst"
        type = "zip";
        interval = "04:31"; # hourly, daily, weekly, monthly
        file = null;
        backupDir = "${config.services.gitea.stateDir}/dump";
      };

      ##########
      # CONFIG #
      ##########

      # settings = {
      #   session = {
      #     COOKIE_SECURE = false; # for https
      #   };

      #   service = { DISABLE_REGISTRATION = false; };

      #   server = {
      #     STATIC_ROOT_PATH = config.services.gitea.package.data;
      #     SSH_PORT = 22;
      #     ROOT_URL = "http://${config.services.gitea.settings.server.DOMAIN}:${
      #         toString config.services.gitea.settings.server.HTTP_PORT
      #     }/";
      #     PROTOCOL = "http";
      #     HTTP_PORT = 3000;
      #     HTTP_ADDR = if lib.hasSuffix "+unix" cfg.settings.server.PROTOCOL then
      #       "/run/gitea/gitea.sock"
      #     else
      #       "0.0.0.0";
      #     DOMAIN = "localhost";
      #     DISABLE_SSH = false;
      #   };

      #   log = {
      #     ROOT_PATH = "${config.services.gitea.stateDir}/log";
      #     # "Trace", "Debug", "Info", "Warn", "Error", "Critical"
      #     LEVEL = "Info";
      #   };
      # };

      # extraConfig = null;

      ######
      # DB #
      ######

      # database = {
      #   createDatabase = true;

      #   type = "sqlite3"; # "sqlite3", "mysql", "postgres"
      #   socket = run;
      #   port = if config.services.gitea.database.type != "postgresql" then
      #     3306
      #   else
      #     5432;
      #   path = "${config.services.gitea.stateDir}/data/gitea.db";
      #   passwordFile = null;
      #   password = "";

      #   user = "gitea";
      #   name = "gitea";
      #   host = "127.0.0.1";
      # };

      ############
      # DEFAULTS #
      ############

      # user = "gitea";
      # group = "gitea";
      # useWizard = false; # let nix handle this

      # camoHmacKeyFile = null;
      # appName = "gitea: Gitea Service";
      # package = pkgs.gitea;
      # metricsTokenFile = null;
      # mailerPasswordFile = null;

      # large file storage
      # lfs = {
      #   enable = false;
      #   contentDir = "${config.services.gitea.stateDir}/data/lfs";
      # };

      # services.gitea-actions-runner = {
      #   package = pkgs.gitea-actions-runner;

      #   instances.name = {
      #     enable = true;

      #     # Gitea/Forgejo
      #     url = "";
      #     token = null;
      #     tokenFile = null;

      #     name = "";
      #     labels = [ ];
      #     settings = { }; # act_runner daemon config
      #     hostPackages = with pkgs; [
      #       bash
      #       coreutils
      #       curl
      #       gawk
      #       gitMinimal
      #       gnused
      #       nodejs
      #       wget
      #     ];
      #   };
      # };
    };
  };
}
