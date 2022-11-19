{ config, pkgs, ... }:

{
  fileSystems."/mnt/windows" = {
    device = "/dev/nvme0n1p3";
    fsType = "ntfs";
    options = ["rw" "uid=1000" "nofail"];
  };
}
