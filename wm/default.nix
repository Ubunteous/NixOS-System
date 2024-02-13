{ config, lib, ... }:

with lib;
{
  options.wm.enable = mkEnableOption "Window Managers";

  imports = [
    # current Desktop Environment or Windows Manager 
    ./cinnamon.nix # => has a built-in bar 
    ./xmonad.nix # => can use xmobar or taffybar

    ./leftwm.nix # => must use polybar
    ./sway.nix # => has a built-in bar
    ./qtile.nix # => has a built-in bar
    ./hyprland.nix # => must uses waybar
  ];
}
