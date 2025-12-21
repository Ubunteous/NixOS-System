{ config, lib, ... }:

with lib;
let
  cfg = config.lab.filebrowser;
  labcfg = config.lab;
in {
  # imports = [ ../../modules/filebrowser.nix ]; # now officially in nix

  options.lab.filebrowser = {
    enable = mkEnableOption "Enables support for filebrowser";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.filebrowser = {
      enable = true;
      openFirewall = true;

      # noauth = true;
      # dirs need to belong to root user
      # rootDir = "${labcfg.dataDir}/";

      settings = {
        port = 8888;
        noauth = true;
        address = "0.0.0.0";
        root = "${labcfg.dataDir}";

        # limitation: --x-mode stored as row integer
        fileMode = 436; # filebrowser config set --file-mode=0664
        dirMode = 509; # filebrowser config set --dir-mode=0775
      };

      user = "multimedia"; # fix for zfs only allowing user access on mount
      # group = "filebrowser";
      # package = pkgs.filebrowser;.
    };
  };
}
