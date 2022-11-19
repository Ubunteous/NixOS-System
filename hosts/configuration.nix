{ lenovo-thinkpad-t14s, home-manager, user, ... }:

# Options: config, pkgs, lib, modulesPath, inputs, ... 
# Help: man configuration.nix(5) or nixos-help’
{          
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  programs.dconf.enable = true; # for themes and more

  home-manager.users.${user}.home.sessionVariables = {
    EDITOR = "emacs";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  };

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
      ../core/services.nix
      ../core/sound.nix
      ../core/file-systems.nix
      ../core/system-packages.nix

      ../core/neovim.nix
      
      #############
      #   USERS   #
      #############

      ../users/user-account.nix
      
      ######################
      #   WINDOW MANAGER   #
      ######################
      
      # current Desktop Environment or Windows Manager 
      # ../wm/cinnamon.nix
      # ../wm/leftwm.nix # => uses polybar
      # ../wm/sway.nix # => built-in bar
      # ../wm/qtile.nix # => built-in bar
      ../wm/xmonad.nix # => uses xmobar or taffybar
      # Try later: Hyprland and lightdm-slick-greeter (cinnamon)

      ###################
      #   PROGRAMMING   #
      ###################
      
      ../programming/C.nix
      ../programming/LaTeX.nix
      ../programming/Python.nix
      # ../programming/Haskell.nix
      # ../programming/Other.nix

      ####################
      #   HOME MANAGER   #
      ####################

      ../home/mime.nix # another app is creating mimes
      ../home/xautolock.nix # replacing it with a service
      ../home/dunst.nix
      ../home/picom.nix
      ../home/flameshot.nix
      ../home/themes.nix
      ../home/alacritty.nix
      ../home/kitty.nix
      ../home/zsh.nix
      ../home/fish.nix
      ../home/bash.nix
      ../home/git.nix
      
      # Unstable: "https://github.com/nix-community/home-manager/archive/master.tar.gz";
      # Troubleshoot: systemctl status "home-manager-$USER.service"
      # Hint: Home manager hates when a config file already exists
      # For unsupported apps: home.file."path/to/file".source = ./a/dotfile/repo/file;
    ];

  ############
  #   Misc   #
  ############

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Documentation: man configuration.nix
  # Documentation (web): https://nixos.org/nixos/options.html
  system.stateVersion = "22.05"; # Do not change this value
}
