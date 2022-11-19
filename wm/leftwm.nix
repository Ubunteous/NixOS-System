{ ... }:
# imported from services.nix

{
  # Enable the Left Window Manager.
  # services.xserver.displayManager.defaultSession = "none+leftwm";
  services.xserver.windowManager.leftwm.enable = true;
}
