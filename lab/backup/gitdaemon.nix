{ config, lib, ... }:

with lib;
let
  cfg = config.lab.gitdaemon;
  labcfg = config.lab;
in {

  options.lab.gitdaemon = {
    enable = mkEnableOption "Enables support for gitdaemon";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.gitDaemon = {
      enable = true;

      repositories = [ "/var/www/git" ];

      port = 9418;
      listenAddress = "0.0.0.0";

      # Remap all path requests as relative to the given path
      # Ex: with /srv/git, pull git://example.com/hello.git = git://example.com/srv/git/hello.git
      basePath = "/var/www/git";

      # options = "";

      # user = "git";
      # group = "git";
      # package = pkgs.git;

      # Publish all directories that look like Git repos even if missing git-daemon-export-ok file
      # If disabled, you need to touch .git/git-daemon-export-ok in each repo you want the daemon to publish
      # Warning: enabling this without a repos whitelist/basePath publishes every git repository you have
      # exportAll = false;
    };
  };
}
