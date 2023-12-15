{ pkgs, ... }:

{
  ############
  #   BOOT   #
  ############

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # boot.loader.grub.configurationLimit = 5; # if does not work? maybe because I use systemd

  # timeout until boots default menu item
  # if does not work, use t binding at boot to set timeout
  boot.loader.timeout = 3;

  # Only show 2 latests generations on grub
  # If you need to rollback to an older generation, use:
  # nix profile rollback --to 300 # with last number being the gen num
  # Note: older generations are only hidden. Not deleted from disk
  # See /nix/var/nix/profiles/ for links to generations on disk
  boot.loader.systemd-boot.configurationLimit = 2;
  
  # alt: hardKernel_4_14, hardkernel_latest
  # sudo nixos-rebuild boot --flake '.nix.d/#' && reboot
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  
  # System Requests
  boot.kernel.sysctl."kernel.sysrq" = 1;

  # enable touchpad
  boot.blacklistedKernelModules = [ "elan_i2c" ]; # lenovo fix touchpad

  # Bluetooth
  hardware.bluetooth.enable = false;

  ##################
  #   LID ACTION   #
  ##################

  services.logind.lidSwitch = "lock"; # "lock", "suspend"
  # services.logind.lidSwitchExternalPower = ;
  # services.logind.lidSwitchDocked = ; # lid closed and another monitor added

  #############################
  #   ENVIRONMENT VARIABLES   #
  #############################

  # make keepassxc and vlc fonts bigger
  # environment.sessionVariables = {
  environment.variables = {
    "QT_SCALE_FACTOR" = "1.25";
  };

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
}
