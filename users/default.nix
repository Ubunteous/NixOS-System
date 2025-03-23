{ lib, ... }:

with lib; {
  options.user.enable = mkEnableOption "User Options";

  imports = [
    ./user.nix
    ./packages.nix
    ./music.nix
    ./visual_art.nix
    ./input-remapper.nix
    # ./stylix.nix
  ];
}
