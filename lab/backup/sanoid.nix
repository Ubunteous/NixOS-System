{ config, lib, ... }:

with lib;
let
  cfg = config.lab.sanoid;
  labcfg = config.lab;
in {

  options.lab.sanoid = {
    enable = mkEnableOption
      "Enables support for sanoid (which comes bundled with syncoid)";
  };

  ###########
  # syncoid #
  ###########

  # syncoid data/images/vm root@remotehost:backup/images/vm # ssh share
  # -r recursive
  # --compress # for network transfer
  # --skip-parent
  # --exclude-datasets=REGEX
  # --include/exclude-snaps=REGEX

  config = mkIf (labcfg.enable && cfg.enable) {
    services.sanoid = {
      enable = true;

      templates = {
        "frequent-backups" = {
          # how many snapshots should be made
          daily = 6;
          monthly = 4;
          yearly = 20;
          # hourly = null;

          autosnap = true; # null (default) or boolean
          autoprune = true; # null (default) or boolean
        };
      };

      # see github page (extra args) and sanoid.defaults.conf
      # settings = {};
      # extraArgs = []; # "--verbose" "--readonly" "--debug"

      datasets."name".useTemplate = [ "frequent-backups" ];

      ############
      # DEFAULTS #
      ############

      # datasets."name" = {
      #   useTemplate = [ ];

      #   yearly = 20;
      #   monthly = 4;
      #   daily = null;
      #   hourly = null;

      #   # probably a duplicate
      #   use_template = [];

      #   # recursively snapshot dataset children
      #   # set to boolean or "zfs" to prevent overriding child datasets settings
      #   recursive = false;
      #   process_children_only = false;
      #   processChildrenOnly = false;

      #   autosnap = null; # boolean
      #   autoprune = null; # boolean
      # };

      # package = pkgs.sanoid;
      # interval = "hourly"; # how often to run sanoid
    };
  };
}
