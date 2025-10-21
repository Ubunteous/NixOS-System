{ lib, ... }:

with lib; {
  options.user.enable = mkEnableOption "User Options";

  imports = [
    ./user.nix
    ./packages/main.nix
    ./packages/core.nix
    ./packages/srm.nix
    ./music.nix
    ./visual-art.nix
    # ./steam.nix
    # ./stylix.nix
    # ./input-remapper.nix
  ];
}
