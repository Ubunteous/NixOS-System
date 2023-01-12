{ pkgs, user, ... }:
# imported from services.nix

{
  # Enable the Sway Compositor.
  programs.hyprland.enable = true;

  users.users.${user}.packages = with pkgs; [
    hyprpaper
  ];
}

