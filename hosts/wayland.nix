{ lenovo-thinkpad-t14s, config, pkgs, user, ... }:

# Options: config, pkgs, lib, modulesPath, inputs, ... 
# Help: man configuration.nix(5) or nixos-help’
{          
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;

  # home-manager.useUserPackages = true;
  # home-manager.useGlobalPkgs = true;
  # home-manager.users.${user}.home.stateVersion = "22.11";

  # unnecessary as its absence does not break the other host
  # users.users.${user}.packages = with pkgs; [home-manager];

  # programs.dconf.enable = true; # for themes and more

  # home-manager.users.${user}.home.sessionVariables = {
  #   EDITOR = "emacs";
  #   BROWSER = "firefox";
  #   TERMINAL = "alacritty";
  # };

  users.users.ubunteous = {
    isNormalUser = true;
    description = "ubunteous";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ kitty ];
  };
  
  # Configure console keymap
  console.keyMap = "fr";

  ###############
  #   IMPORTS   #
  ###############

  imports =
    [
      # Impure. fix wifi on lenovo
      # <nixos-hardware/lenovo/thinkpad/t14s/amd/gen1>
      # ./hardware-configuration.nix # moved to flake

      ############
      #   CORE   #
      ############

      ../core/boot.nix
      ../core/networking.nix
      # ../core/services.nix
      ../core/gdm.nix
      ../core/sound.nix
      ../core/file-systems.nix
      ../core/system-packages.nix
      # ../core/neovim.nix
      
      #############
      #   USERS   #
      #############

      # ../users/user.nix # copied above
      # ../users/user-packages.nix # only requires home-manager defined above
      
      ###################
      #   PROGRAMMING   #
      ###################
      
      # ../programming/C.nix
      # ../programming/LaTeX.nix
      # ../programming/Python.nix
      # ../programming/Haskell.nix
      # ../programming/Other.nix

      ####################
      #   HOME MANAGER   #
      ####################

      # ../home/mime.nix # another app is creating mimes
      # ../home/xautolock.nix # replacing it with a service
      # # ../home/dunst.nix
      # # ../home/picom.nix
      # ../home/flameshot.nix
      # ../home/themes.nix
      # ../home/alacritty.nix
      # ../home/kitty.nix
      # ../home/zsh.nix
      # ../home/fish.nix
      # # ../home/bash.nix
      # # ../home/git.nix
      
      # Unstable: "https://github.com/nix-community/home-manager/archive/master.tar.gz";
      # Troubleshoot: systemctl status "home-manager-$USER.service"
      # Hint: Home manager hates when a config file already exists
      # For unsupported apps: home.file."path/to/file".source = ./a/dotfile/repo/file;

      ###################
      #   VIRTUAL BOX   #
      ###################
      
      # ../misc/virtual-box.nix
    ];
  # Documentation: man configuration.nix
  # Documentation (web): https://nixos.org/nixos/options.html
  system.stateVersion = "22.05"; # Do not change this value
}
