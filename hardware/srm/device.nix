{ config, lib, ... }:

with lib;
let
  cfg = config.core.boot-srm;
  corecfg = config.core;
in {
  options.core.boot-srm = { enable = mkEnableOption "Boot options for srm"; };

  config = mkIf (corecfg.enable && cfg.enable) {
    fileSystems."/mnt/windows" = {
      device = "/dev/disk/by-uuid/DC5CAD5B5CAD30E6";
      fsType = "ntfs";
      options = [ "rw" "uid=1000" "gid=1000" "dmask=007" "fmask=117" "nofail" ];
    };
  };
}
