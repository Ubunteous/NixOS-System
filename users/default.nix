{ lib, ... }:

with lib; {
  options.user.enable = mkEnableOption "User Options";

  imports = [
    ./user.nix
    ./packages.nix
    ./music.nix
    ./visual-art.nix
    # ./steam.nix
    # ./stylix.nix
    # ./input-remapper.nix
  ];
}
