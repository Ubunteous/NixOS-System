{ lib, ... }:

with lib; {
  options.user.enable = mkEnableOption "User Options";

  imports = [
    ./user.nix
    ./packages.nix
    ./music.nix
    ./visual-art.nix
    ./input-remapper.nix
    # ./stylix.nix
  ];
}
