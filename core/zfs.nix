{ config, lib, ... }:

with lib;
let
  cfg = config.core.zfs;
  corecfg = config.core;
in {
  options.core.zfs = { enable = mkEnableOption "ZFS options"; };

  config = mkIf (corecfg.enable && cfg.enable) {

    # deactivate hibernation to prevent corruption
    # Note: a non zfs swap partition can also be used
    boot.kernelParams = [ "nohibernate" ];

    # get it with the hostid command
    networking.hostId = "8425e349";

    ###########
    #   ZFS   #
    ###########

    services.zfs = {
      # zed = {
      #   settings
      #   enableMail
      # };

      # trim = {
      #   enable = true;
      #   randomizedDelaySec = "6h";
      #   interval = "weekly";
      # };

      # expandOnBoot = "disabled"; # either "all" or [ "names" ]

      # autoSnapshot = {
      #   enable = false;

      #   frequent = 4; # 15mn
      #   hourly = 24;
      #   daily = 7;
      #   weekly = 4;
      #   monthly = 12;

      #   flags = "-k -p";
      # };

      autoScrub = {
        enable = true;

        # randomizedDelaySec = "6h";
        # pools = []; # [ "names" ];
        # interval = "monthly";
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
