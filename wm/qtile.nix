{ ... }:
# imported from services.nix

{
  # Enable the QTile Window Manager.
  # services.xserver.displayManager.defaultSession = "none+qtile";
  services.xserver.windowManager.qtile.enable = true;
}
