{ lib, ... }:

with lib; {
  options.core.enable = mkEnableOption "Core configuration";

  imports = [
    ./boot.nix
    ./networking.nix
    ./misc.nix

    ./zfs.nix
    ./sound.nix

    ./xserver.nix
    ./packages.nix

    ./kanata.nix
    ./nix-ld.nix
  ];
}
