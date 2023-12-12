{ config, pkgs, ... }:

# To mount manually, use this command with the correct partition name (found with lsblk) and mount point:
# sudo mount /dev/nvme0n1p4 /mnt/windows

{
  # Mount external drives (NTFS support)
  boot.supportedFilesystems = [ "ntfs" ]; # lenovo yoga 7 fix (mount usb / hdd)

  fileSystems."/mnt/windows" = {
    device = "/dev/nvme0n1p4";
    fsType = "ntfs"; # "ntfs3";
    options = ["rw" "uid=1000" "gid=1000" "dmask=007" "fmask=117" "nofail"];
  };
  }
