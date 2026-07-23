{ user, ... }:

# Options: config, pkgs, lib, modulesPath, inputs, ...
# Help: man configuration.nix(5) or nixos-help’
{
  ##################
  #     IMPORTS    #
  ##################

  imports = [
    ../core
    ../users
    ../wm
    ../lab
    ../programming
  ];

  languages = {
    enable = true;
    # python.enable = true;
  };

  #--------------------#
  #        CORE        #
  #--------------------#

  core = {
    enable = true;

    boot.enable = true;
    networking.enable = true;
    zfs.enable = true;
    misc.enable = true;

    xserver = {
      enable = true;
      displayManager = "sddm"; # sddm, gdm, lightdm
    };

    sound.enable = true;
    system-packages.enable = true;

    kanata.enable = true;
    nix-ld.enable = false;
  };

  #--------------------#
  #        USER        #
  #--------------------#

  user = {
    enable = true;
    main.enable = true;

    packages.core.enable = true;
  };

  #--------------------#
  #        HOME        #
  #--------------------#

  home-manager = {
    extraSpecialArgs.user = "${user}";

    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "backup";
    # sharedModules = [ nur.hmModules.nur ];

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
        picom.enable = true;
        themes.enable = true;
        flameshot.enable = true;
        xautolock.enable = true;
        redshift.enable = true; # see config for activation

        nix-direnv.enable = true;
        xdg-user-dir.enable = false;

        terminal = {
          enable = true;

          zsh.enable = true;
          wezterm.enable = true;
        };

        dots.enable = true;
      };
    };
  };

  #--------------------#
  #         LAB        #
  #--------------------#

  lab = {
    enable = true;

    virtualbox.enable = true;
    homepage.enable = true;

    radarr.enable = true; # 7878 movies
    bazarr.enable = true; # 6767 subtitles
    sonarr.enable = true; # 8989 tv series
    prowlarr.enable = true; # 9696 indexer
    qbittorrent.enable = true; # 8080
  };

  #--------------------#
  #          WM        #
  #--------------------#

  wm = {
    enable = true;

    main = "none+xmonad";
    display_backend = "x11"; # x11 or wayland
    xmonad.enable = true;
  };

  ############
  #    Misc    #
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
  system.stateVersion = "25.05"; # Do not change this value
}
