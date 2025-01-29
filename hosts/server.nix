{ pkgs, user, ... }:

# Options: config, pkgs, lib, modulesPath, inputs, ... 
# Help: man configuration.nix(5) or nixos-help’
{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  programs.dconf.enable = true; # for themes and more

  # removes error messages related to wifi command
  # may conflict with power-daemon in zfs config
  services.tlp.enable = true;

  ################
  #   HARDWARE   #
  ################

  # temporary fix for unstable channel (March 2023)
  # pkgs.rtw89-firmware is now part of linux-firmware
  # therefore, override hardware.firmware to remove rtw89
  # hardware.firmware = [ ];
  hardware.enableRedistributableFirmware = true;
  hardware.firmware = [ ];

  # this may be useful for a future nix upgrade to unstable
  # hardware.enableRedistributableFirmware = true;

  ###############
  #   IMPORTS   #
  ###############

  imports = [
    ../core
    ../lab
    ../users
    ../wm
    ../programming

    ############
    #   MAIL   #
    ############

    # setup: http://www.macs.hw.ac.uk/~rs46/posts/2014-01-13-mu4e-email-client.html
    # ../home/mail/nm-isync.nix # isync with notmuch # isync bug eof in NixOS 22.11
    # # ../home/mail/mu-imap.nix # offlineimap with mu
    # ../home/mail/gnupg.nix
    # ../home/mail/maildata.nix
    # ../home/mail/maildata-home.nix
  ];

  #--------------------#
  #        CORE        #
  #--------------------#

  core = {
    enable = true;

    boot.enable = true;
    networking.enable = true;

    xserver = {
      enable = true;
      displayManager = "sddm"; # sddm, gdm, lightdm
    };

    sound.enable = true;
    system-packages.enable = true;

    kanata.enable = true;
  };

  #--------------------#
  #        LAB         #
  #--------------------#

  lab = {
    enable = false;
    # ssh.enable = true;

    # overview. add widgets once enable other services
    homepage.enable = true; # 8082

    k3s.enable = false;
    podman.enable = true;
    # virtualbox.enable = false;

    wireguard.enable = false;
    # navidrome.enable = false;
    # unbound.enable = false;
    # bind.enable = false;
    adguard.enable = false; # 3000
    # restic.enable = true; # 8000
    # immich.enable = true; # 3001
    syncthing.enable = true; # 8384

    # fail2ban.enable = true;
    # authelia.enable = true;

    ##################
    #   multimedia   #
    ##################

    # kodi.enable = false; # also defined with home-manager
    # jellyfin.enable = false; # 8096
    # plex.enable = true; # 8096 # localhost:32400/web
    # jellyseer.enable = false; # 5055
    # shiori.enable = false; # 8080 => 2525 bookmarks
    # tautulli.enable = true; # 8181 plex manager
    # kavita.enable = false; # 5000 reading server (library)

    ###############
    #   servarr   #
    ###############

    radarr.enable = false; # 7878 movies
    bazarr.enable = false; # 6767 subtitles
    sonarr.enable = false; # 8989 tv series
    prowlarr.enable = false; # 9696 indexer

    readarr.enable = false; # 8787 books
    lidarr.enable = false; # 8686 music

    ##################
    #   monitoring   #
    ##################

    # grafana.enable = true; # 3000 => 3002
    # prometheus.enable = true; # 9090
    # loki.enable = false;

    #############
    #   proxy   #
    #############

    caddy.enable = false; # 2019 (default admin port)
    # traefik.enable = false;
    # nginx.enable = true; # proxyPass set to 3002 like grafana
  };

  #--------------------#
  #        USER        #
  #--------------------#

  user = {
    enable = true;
    server.enable = true;
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

        firefox.enable = true; # nur missing without osConfig
        firefox.on-nixos = true;

        git.enable = true;
        mime.enable = true;
        dunst.enable = true;
        themes.enable = true;
        flameshot.enable = false; # 1/2025. service broken
        xautolock.enable = true;
        redshift.enable = true; # see config for activation
        # kodi.enable = false;

        terminal = {
          enable = true;

          zsh.enable = true;
          wezterm.enable = true;
        };

        qbittorrent.enable = true;
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
  system.stateVersion = "24.05"; # Do not change this value
}
