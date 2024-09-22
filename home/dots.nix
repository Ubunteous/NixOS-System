{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.home.dots;
  homecfg = config.home;
in
{
  options.home.dots = {
    enable = mkEnableOption "Put dot files in .config and ~/";
  };

  config = mkIf (homecfg.enable && cfg.enable) {
    # Still experimental. Will be tested later.

    ###########
    #   XDG   #
    ###########

    # files in ~/.config/
    xdg.configFile."eww/".source = ../files/eww;
    xdg.configFile."rofi/".source = ../files/rofi;
    xdg.configFile."p10k/p10k.zsh".source = ../files/p10k.zsh;

    # xdg.configFile."leftqm/".source = ../files/dots/leftwm;
    # xdg.configFile."polybar/".source = ../files/dots/polybar;
    # xdg.configFile."sway/config".source = ../files/dots/sway;
    # xdg.configFile."hyprland/".source = ../files/dots/hyprland;
    # xdg.configFile."qtile/config.py".source = ../files/dots/qtile.py;
    # xdg.configFile."kmonad/kmonad.kbd".source = ../files/dots/kmonad.kbd;
    
    # files in ~/
    home.file.".tridactylrc".source = ../files/tridactylrc;

    # Note: the wallpaper should be placed in ~/background-image
    # Too big for dots.nix: Reaper, XMonad, Emacs
    };
}
