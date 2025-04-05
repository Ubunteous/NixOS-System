{ config, lib, ... }:

with lib;
let
  cfg = config.core.boot-server;
  corecfg = config.core;
in {
  options.core.boot-server = {
    enable = mkEnableOption "Boot options for server";
  };

  config = mkIf (corecfg.enable && cfg.enable) {
    # # external ntfs hdd
    # fileSystems."/run/media/storage" = {
    #   device = "/dev/disk/by-uuid/38D49266D49225E2";
    #   fsType = "ntfs"; # "ntfs3";
	#
    #   # Defaults of diskutils: "nosuid" "nodev" "nofail" "noauto" "x-gvfs-show"
    #   options = [ "rw" "uid=1000" "gid=1000" "dmask=007" "fmask=117" "nofail" ];
    # };

    # better to have legacy mountpoints imported as below
    boot.zfs.extraPools = [ "main" ];

	# # external zfs hdd
	# fileSystems."/run/media/data/musics" = {
    #   device = "main/musics";
    #   fsType = "zfs";
    # };
  };
}
