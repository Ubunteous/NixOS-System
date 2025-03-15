{ config, lib, ... }:

with lib;
let
  cfg = config.lab.filebrowser;
  labcfg = config.lab;
in {
  imports = [ ../../modules/filebrowser.nix ];

  options.lab.filebrowser = {
    enable = mkEnableOption "Enables support for filebrowser";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.filebrowser = {
      enable = true;

      port = 8888;
      address = "0.0.0.0";
      openFirewall = true;

      noauth = true;
      # dirs need to belong to root user
      rootDir = "${labcfg.dataDir}/media/";

      # user = "filebrowser";
      # group = "filebrowser";
      # package = pkgs.filebrowser;.
    };
  };
}
