{ lib, ... }:

with lib; {
  options.wm = {
    enable = mkEnableOption "Window Managers";

    main = mkOption {
      type = lib.types.str;
      description = "Main Window Managers";
    };

    display_backend = mkOption {
      type = lib.types.enum [ "x11" "wayland" ];
      description = "Either X11 or Wayland";
    };
  };

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
