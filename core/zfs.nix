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
      zed = {
        # settings
        # enableMail
      };

      trim = {
        # enable
        # randomizedDelaySec
        # interval
      };

      # expandOnBoot

      autoSnapshot = {
        # enable
        # weekly
        # monthly
        # hourly
        # frequent
        # flags
        # daily
      };
      autoScrub = {
        enable = true; # default: monthly

        # randomizedDelaySec
        # pools
        # interval = "monthly";
      };

      autoReplication = {
        # username
        # remoteFilesystem
        # recursive
        # identityFilePath
        # localFilesystem
        # host
        # followDelete
        # enable
      };
    };
  };
}
