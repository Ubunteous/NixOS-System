{ lenovo-thinkpad-t14s, home-manager, user, ... }:

# Options: config, pkgs, lib, modulesPath, inputs, ... 
# Help: man configuration.nix(5) or nixos-help’
{          
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  home-manager.users.${user}.home = {
    stateVersion = "22.11";
    sessionVariables = {
      EDITOR = "emacs";
      BROWSER = "firefox";
      TERMINAL = "alacritty";
    };
  };

  programs.dconf.enable = true; # for themes and more

  # temporary fix for unstable channel (March 2023)
  # pkgs.rtw89-firmware is now part of linux-firmware
  # therefore, override hardware.firmware to remove rtw89
  # hardware.firmware = [ ];

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
      # ../core/sddm.nix
      # ../core/gdm.nix
      ../core/lightdm.nix
      ../core/sound.nix
      ../core/file-systems.nix
      ../core/system-packages.nix
      # ../core/neovim.nix
      
      #############
      #   USERS   #
      #############

      ../users/user.nix
      ../users/user-packages.nix
      # ../users/musnix.nix

      ######################
      #   WINDOW MANAGER   #
      ######################
      
      # current Desktop Environment or Windows Manager 
      # ../wm/cinnamon.nix # => has a built-in bar 
      # ../wm/leftwm.nix # => must use polybar
      # ../wm/sway.nix # => has a built-in bar
      # ../wm/qtile.nix # => has a built-in bar
      # ../wm/hyprland.nix # => must uses waybar
      ../wm/xmonad.nix # => can use xmobar or taffybar

      ###################
      #   PROGRAMMING   #
      ###################
      
      #### ../programming/C.nix
      #### ../programming/LaTeX.nix
      #### ../programming/Python.nix
      #### ../programming/Clojure.nix
      # ../programming/Java.nix
      # ../programming/Haskell.nix
      # ../programming/Other.nix

      ####################
      #   HOME MANAGER   #
      ####################

      # setup: http://www.macs.hw.ac.uk/~rs46/posts/2014-01-13-mu4e-email-client.html
      # ../home/mail/nm-isync.nix # isync with notmuch # isync bug eof in NixOS 22.11
      ../home/mail/mu-imap.nix # offlineimap with mu
      ../home/mail/gnupg.nix
      
      ../home/mime.nix # another app is creating mimes
      ../home/xautolock.nix # replacing it with a service
      ../home/dunst.nix
      # ../home/picom.nix
      # ../home/flameshot.nix
      # ../home/themes.nix
      ../home/alacritty.nix
      ../home/kitty.nix
      ../home/zsh.nix
      ../home/fish.nix
      # ../home/bash.nix
      # ../home/git.nix

      # for OB-xD synth
      # ../home/xdg-user-dir.nix
      
      # Unstable: "https://github.com/nix-community/home-manager/archive/master.tar.gz";
      # Troubleshoot: systemctl status "home-manager-$USER.service"
      # Hint: Home manager hates when a config file already exists
      # For unsupported apps: home.file."path/to/file".source = ./a/dotfile/repo/file;

      ###################
      #   VIRTUAL BOX   #
      ###################
      
      ../core/virtual-box.nix
    ];

  ############
  #   Misc   #
  ############

  ## NOT useful for the time being => gnupg.agent useful with mail
  # Some programs need SUID wrappers, can be configured further or are started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Documentation: man configuration.nix
  # Documentation (web): https://nixos.org/nixos/options.html
  system.stateVersion = "22.05"; # Do not change this value
}
