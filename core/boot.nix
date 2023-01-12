{ ... }:

{
  ############
  #   BOOT   #
  ############

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # boot.loader.grub.configurationLimit = 5; # does not work?
  boot.loader.timeout = 3; # timeout until boots default menu item

  # System Requests
  boot.kernel.sysctl."kernel.sysrq" = 1;

  # Mount external drives (NTFS support)
  boot.supportedFilesystems = [ "ntfs" ]; # lenovo yoga 7 fix (mount usb / hdd)

  # enable touchpad
  boot.blacklistedKernelModules = [ "elan_i2c" ]; # lenovo fix touchpad

  # Bluetooth
  hardware.bluetooth.enable = false;

  # grub device
  # boot.loader.grub.device = # probably "/dev/sda"

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
  #hardware.firmware = [ pkgs.rtw89-firmware ];

  # For mainline support of rtw89 wireless networking
  #boot.kernelPackages = lib.mkIf (lib.versionOlder pkgs.linux.version "5.16") pkgs.linuxPackages_latest;

  # Enable energy savings during sleep
  #boot.kernelParams = ["mem_sleep_default=deep"];
}
