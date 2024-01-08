{ ... }:

{    
  imports = [
    # current Desktop Environment or Windows Manager 
    ../wm/cinnamon.nix # => has a built-in bar 
    ../wm/xmonad.nix # => can use xmobar or taffybar

    # ../wm/leftwm.nix # => must use polybar
    # ../wm/sway.nix # => has a built-in bar
    # ../wm/qtile.nix # => has a built-in bar
    # ../wm/hyprland.nix # => must uses waybar
  ];
}


  
