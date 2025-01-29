{ lib, ... }:

with lib; {
  options.user.enable = mkEnableOption "User Options";

  imports = [
    ./user.nix
    ./server.nix
    ./packages.nix
    ./music.nix
    ./visual_art.nix
    # ./stylix.nix
  ];
}
