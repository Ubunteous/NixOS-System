{ lib, ... }:

with lib;
{
  options.home.music.enable = mkEnableOption "Home manager vst plugins";

  imports = [
    ./apulsoft.nix
    ./tdr.nix
    ./tal.nix
    ./auburn.nix
    ./ob-xf.nix
    ./toneboosters.nix
    ./u-he.nix
    ./u-he-legacy.nix

    # ./glitch.nix
    # ./reaimgui.nix
  ];
}
