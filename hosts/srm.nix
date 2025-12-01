{ user, ... }:

# Options: config, pkgs, lib, modulesPath, inputs, ... 
# Help: man configuration.nix(5) or nixos-help’
{
  ###############
  #   IMPORTS   #
  ###############

  imports = [ ../core ../lab ../users ../wm ../programming ];

  #--------------------#
  #        CORE        #
  #--------------------#

  core = {
    enable = true;

    boot.enable = true;
    boot-srm.enable = true;
    networking.enable = true;

    xserver = {
      enable = true;
      displayManager = "sddm"; # sddm, gdm, lightdm
      keyboardLayout = "colemak"; # "qwerty" (default), "colemak"
    };

    sound.enable = true;
    system-packages.enable = true;

    kanata.enable = true;
  };

  #--------------------#
  #        LAB         #
  #--------------------#

  lab = {
    enable = true;

    ssh.enable = true;

    #homepage = {
    #  enable = true; # 8082
    #  address = "192.168.1.99"; # server.local or localhost or 192.168.1.99
    #};

    syncthing = {
      enable = true; # 8384
      extraSyncDirs = false;
    };

    podman.enable = true;
  };

  #------------------------#
  #          USER          #
  #------------------------#

  user = {
    enable = true;
    prince.enable = true;
    packages = {
      core.enable = true;
      srm.enable = true;
    };
  };

  #--------------------#
  #        HOME        #
  #--------------------#

  home-manager = {
    extraSpecialArgs.user = "${user}";

    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "backup";

    users.${user} = {
      imports = [ ../home ];

      config.home = {
        enable = true;

        firefox = {
          enable = true; # nur missing without osConfig
          on-nixos = true;
        };

        git.enable = true;
        mime.enable = true;
        dunst.enable = true;
        themes.enable = true;
        flameshot.enable = true;
        xautolock.enable = true;
        redshift.enable = true; # see config for activation
        vscode.enable = true;

        terminal = {
          enable = true;

          zsh.enable = true;
          wezterm.enable = true;
        };

        dots.enable = true;
      };
    };
  };

  #------------------------#
  #        LANGUAGES       #
  #------------------------#

  languages = {
    enable = true;
    nix.enable = true;
    janet.enable = true;
    javascript.enable = true;
    postgresql.enable = true;
  };

  #--------------------#
  #         WM         #
  #--------------------#

  wm = {
    enable = true;

    # none+xmonad/qtile or cinnmon/hyprland
    main = "none+xmonad";
    display_backend = "x11"; # x11 or wayland

    xmonad.enable = true;
  };

  ############
  #   Misc   #
  ############

  # Documentation: man configuration.nix
  # Documentation (web): https://nixos.org/nixos/options.html
  system.stateVersion = "25.05"; # Do not change this value
}
