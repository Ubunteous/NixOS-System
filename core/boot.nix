{ config, lib, ... }:

with lib;
let
  cfg = config.core.boot;
  corecfg = config.core;
in {
  options.core.boot = { enable = mkEnableOption "Boot options"; };

  config = mkIf (corecfg.enable && cfg.enable) {
    boot = {
      loader = {
        systemd-boot = {
          enable = true;

          # consoleMode = "max";

          # Only show 2 latests generations on grub
          # rollback with nix profile rollback --to <gen-number>
          configurationLimit = 2;
        };

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

        efi.canTouchEfiVariables = true;
        # efi.efiSysMountPoint = "/boot/efi"; # can fail sometimes?

        # timeout until boots default menu item
        # if does not work, use t binding at boot to set timeout
        timeout = 3;
      };

      # supportedFilesystems = [ "ntfs" ]; # lenovo yoga 7 fix (mount usb / hdd)
      supportedFilesystems = [ "ntfs" ]; # "zfs" "ext4" "btrfs"

      # zfs.forceImportRoot = false; # recommended default

      # alt: hardKernel_4_14, hardkernel_latest
      # sudo nixos-rebuild boot --flake '.nix.d/#' && reboot
      # boot.kernelPackages = pkgs.linuxPackages_latest;

      # System Requests
      kernel.sysctl."kernel.sysrq" = 1;

      # enable touchpad
      blacklistedKernelModules = [ "elan_i2c" ]; # lenovo fix touchpad
    };

    # make this id unique to differentiate machines. get it with either:
    # head -c 8 /etc/machine-id # systemd generated id
    # head -c4 /dev/urandom | od -A none -t x4
    # networking.hostId = "50c25169"; # for zfs

    # Bluetooth
    hardware.bluetooth.enable = false;

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

    ######################
    #   KERNEL VERSION   #
    ######################

    # deprecated. need to manually choose a kernel compatible with zfs
    # kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;

    # 6_10 deprecated. maybe switch to 6_6 and
    # figure out later how identify compatible versions
    # by reading zfs release notes https://github.com/openzfs/zfs/releases/tag/zfs-2.2.6
    # boot.kernelPackages = linuxPackages_6_10;
    # boot.kernelPackages = pkgs.linuxPackages_latest;

    #########################
    #   Lenovo Yoga 7 Fix   #
    #########################

    ### Add <nixos-hardware/lenovo/thinkpad/t14s/amd/gen1> to imports = [];
    ### Or uncomment the following lines to fix wifi on the lenovo yoga 7	

    # Wifi support
    # hardware.firmware = [ pkgs.rtw89-firmware ];

    # For mainline support of rtw89 wireless networking
    #boot.kernelPackages = lib.mkIf (lib.versionOlder pkgs.linux.version "5.16") pkgs.linuxPackages_latest;

    # Enable energy savings during sleep
    #boot.kernelParams = ["mem_sleep_default=deep"];
  };
}
