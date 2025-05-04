{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.core.zfs;
  corecfg = config.core;
in {
  options.core.zfs = { enable = mkEnableOption "ZFS options"; };

  config = mkIf (corecfg.enable && cfg.enable) {
    # deactivate hibernation to prevent corruption
    # Note: a non zfs swap partition can also be used
    boot = {
      zfs.forceImportRoot = false;
      kernelParams = [ "nohibernate" ]; # see zfs.allowHibernation
      supportedFilesystems = [ "zfs" ]; # unneccesary but explicit
    };

    # get it with the hostid command
    networking.hostId = "8425e349";

    environment.systemPackages = with pkgs; [ httm ];

    ###########
    #   ZFS   #
    ###########

    services.zfs = {
      # zed = {
      #   settings
      #   enableMail
      # };

      trim = {
        enable = true;
        interval = "weekly";
        # randomizedDelaySec = "6h";
      };

      # expandOnBoot = "disabled"; # either "all" or [ "names" ]

      # autoSnapshot = {
      #   enable = true;
      #   daily = 1;
      #   flags = "--keep=10";
	  #
      #   # frequent = 4; # 15mn
      #   # hourly = 24;
      #   # daily = 7;
      #   # weekly = 4;
      #   # monthly = 12;
	  #
      #   # flags = "-k -p"; # keep and make parent snapshots
      # };

      autoScrub = {
        enable = true;

        # randomizedDelaySec = "6h";
        # pools = []; # [ "names" ];
        interval = "monthly"; # ideal is every 2 weeks
      };

      # autoReplication = {
      #   enable = false;

      #   username
      #   remoteFilesystem
      #   identityFilePath
      #   localFilesystem
      #   host

      #   recursive = true; # snapshot discovery
      #   followDelete = true;
      #   package = pkgs.zfs-replicate;
      # };
    };
  };
}
