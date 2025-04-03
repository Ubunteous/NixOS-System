{ config, lib, ... }:

with lib;
let
  cfg = config.lab.sanoid;
  labcfg = config.lab;
in {

  options.lab.sanoid = {
    enable = mkEnableOption "Enables support for sanoid";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.sanoid = {
      enable = true;

      templates."name" = {
        # how many snapshots should be made
        daily = 6;
        monthly = 4;
        yearly = 20;
        # hourly = null;

        autosnap = true; # null (default) or boolean
        autoprune = true; # null (default) or boolean
      };

      # package = pkgs.sanoid;
      # interval = "hourly"; # how often to run sanoid

      # see github page (extra args) and sanoid.defaults.conf
      # settings = {};
      # extraArgs = []; # "--verbose" "--readonly" "--debug"

      datasets."name" = {
        yearly = 20;
        monthly = 4;
        # daily = null;
        # hourly = null;

        # probably a duplicate
        # use_template = [];
        # useTemplate = [];

        # recursively snapshot dataset children
        # set to "zfs" to prevent overriding child datasets settings
        # recursive = false;
        # process_children_only = false;
        # processChildrenOnly = false;

        # autosnap = null; # boolean
        # autoprune = null; # boolean
      };
    };
  };
}
