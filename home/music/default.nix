{ lib, ... }:

with lib;
{
  options.home.music.enable = mkEnableOption "Home manager vst plugins";

  imports = [
    ./apulsoft.nix
  ];
}
