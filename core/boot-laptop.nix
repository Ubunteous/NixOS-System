{ config, lib, ... }:

with lib;
let
  cfg = config.core.boot-laptop;
  corecfg = config.core;
in {
  options.core.boot-laptop = {
    enable = mkEnableOption "Boot options for laptop";
  };

  config = mkIf (corecfg.enable && cfg.enable) {
    boot = {
      loader = {
        grub = {
          enable = false;
          zfsSupport = true;
          efiSupport = true;
          efiInstallAsRemovable = true;
          mirroredBoots = [{
            devices = [ "nodev" ];
            path = "/boot";
          }];
        };
      };

      # enable touchpad
      blacklistedKernelModules = [ "elan_i2c" ]; # lenovo fix touchpad
    };

    ###################
    #   FILESYSTEMS   #
    ###################

    # To mount manually, use this command with the correct partition name (found with lsblk) and mount point:
    # sudo mount /dev/nvme0n1p4 /mnt/windows

    # Mount external drives (NTFS support)
    fileSystems."/mnt/windows" = {
      # 1/2025. label and device are mutually exclusive. pick one
      # label = "Windows Partition";
      device = "/dev/disk/by-uuid/08B6449AB6448A60";

      # device = "/dev/nvme0n1p4";
      fsType = "ntfs"; # "ntfs3";
      options = [ "rw" "uid=1000" "gid=1000" "dmask=007" "fmask=117" "nofail" ];
    };

    # # required either command to be mounted during boot:
    # # sudo chown -R $USER /mnt/zfs or chown -R :users /mnt/zfs
    # fileSystems."/mnt/zfs" = {
    #   label = "ZFS";
    #   device = "/dev/nvme0n1p7";
    #   fsType = "ext4";
    #   options = [ "rw" "users" ];
    # };

    # depends
    # mountPoint
    # neededForBoot redundant if mounted at /nix/store

    # encrypted.label

    ##################
    #   LID ACTION   #
    ##################

    services.logind.lidSwitch = "lock"; # "lock", "suspend"
    # services.logind.lidSwitchExternalPower = ;
    # services.logind.lidSwitchDocked = ; # lid closed and another monitor added

    #########################
    #   Lenovo Yoga 7 Fix   #
    #########################

    ### Add <nixos-hardware/lenovo/thinkpad/t14s/amd/gen1> to imports = [];
    ### Or uncomment the following lines to fix wifi on the lenovo yoga 7	

    # Wifi support
    # hardware.firmware = [ pkgs.rtw89-firmware ];

    # For mainline support of rtw89 wireless networking
    # boot.kernelPackages = lib.mkIf (lib.versionOlder pkgs.linux.version "5.16") pkgs.linuxPackages_latest;

    # Enable energy savings during sleep
    # boot.kernelParams = ["mem_sleep_default=deep"];
  };
}
