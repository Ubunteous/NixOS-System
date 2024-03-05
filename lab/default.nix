{ lib, ... }:

with lib; {
  options.lab.enable = mkEnableOption "Homelab configuration";
  imports = [ ./podman.nix ./virtual-box.nix ];
}
