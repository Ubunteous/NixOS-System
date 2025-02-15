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

        # grub = {
        #   enable = false;

        #   zfsSupport = true;
        #   efiSupport = true;
        #   efiInstallAsRemovable = true;
        #   mirroredBoots = [{
        #     devices = [ "nodev" ];
        #     path = "/boot";
        #   }];
        # };

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
    };

    # make this id unique to differentiate machines. get it with either:
    # head -c 8 /etc/machine-id # systemd generated id
    # head -c4 /dev/urandom | od -A none -t x4
    # networking.hostId = "50c25169"; # for zfs

    # Bluetooth
    hardware.bluetooth.enable = false;

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
  };
}
