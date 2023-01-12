{ lenovo-thinkpad-t14s, user, pkgs, ... }:

{
  # Delete everything with:             
  # 1) rm /nix/var/nix/gcroots/auto/*
  # 2) nix-collect-garbage -d
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;

  nixpkgs.config.allowUnfree = true;
  environment.binsh = "${pkgs.dash}/bin/dash";

  #######################
  #   SYSTEM PACKAGES   #
  #######################
  
  environment.systemPackages = with pkgs; [
    brightnessctl
    i3lock # brightnessctl -s set 5 && i3lock -ueni ~/Pictures/gem_full.png; brightnessctl -r
    killall
    pamixer
    git
    xautolock
    xkbset # key bindings / sticky keys
    wget
    cinnamon.nemo
    firefox
    gnome.gnome-terminal
    xed-editor
    nano # already installed
  ];

  ###############
  #   IMPORTS   #
  ###############

  users.users.${user}.packages = with pkgs; [
    alacritty
    polybar
    rofi
  ];
  
  imports = [
    ../core/boot.nix
    ../core/networking.nix
    ../core/lightdm.nix
    ../core/sound.nix
    ../core/file-systems.nix    
    ../users/user.nix
    ../wm/xmonad.nix
  ];

  ##############
  #   nanorc   #
  ##############

  programs.nano.nanorc = ''
  set mouse
  set autoindent
  set softwrap
  set tabstospaces
  set tabsize 4
  set linenumbers  
  '';

  system.stateVersion = "22.05"; # Do not change this value
}

