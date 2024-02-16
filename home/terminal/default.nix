{ config, lib, user, ... }:

with lib;
{
  options.home.terminal.enable = mkEnableOption "Home manager terminal configuration";
  
  imports = [
    ./alacritty.nix
    ./bash.nix      
    ./fish.nix
    ./kitty.nix
    ./wezterm.nix
    ./zsh.nix
  ];
}
