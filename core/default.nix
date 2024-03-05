{ lib, pkgs, ... }:

# lib.mkIf (config.networking.hostName == "") { imports = [ ../core/lightdm.nix ]; }

with lib; {
  options.core.enable = mkEnableOption "Core configuration";

  imports = [
    ./boot.nix
    ./networking.nix
    ./sound.nix

    ./xserver.nix
    ./system-packages.nix

    ./kanata.nix
    ./nix-ld.nix
  ];

  ############
  #   MISC   #
  ############

  config = {
    # adb for android interactions ("adbusers")
    # programs.adb.enable = true;
    services.gvfs.enable = true;

    # Whether to enable the Wacom touchscreen/digitizer/tablet.
    # services.xserver.wacom.enable = true;

    # Configure console keymap
    console.keyMap = "fr";

    # no ugly askpass gui anymore with git
    programs.ssh.askPassword = "";

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # Warning: NixOS assumes that Bash is used by default for /bin/sh
    # Dash is faster than bash
    environment.binsh = "${pkgs.dash}/bin/dash";

    # gpg encryption
    # programs.gnupg.agent.enable = true;
    # services.pcscd.enable = true;

    # make keepassxc and vlc fonts bigger
    # environment.sessionVariables = {
    environment.variables = { "QT_SCALE_FACTOR" = "1.25"; };
  };
}
