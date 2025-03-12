{ pkgs, user, ... }:

# Options: config, pkgs, lib, modulesPath, inputs, ... 
# Help: man configuration.nix(5) or nixos-help’
{
  ###############
  #   IMPORTS   #
  ###############

  imports = [ ../core ../lab ../users ../wm ../programming ];

  #--------------------#
  #          CORE          #
  #--------------------#

  core = {
    enable = true;

    boot.enable = true;
    boot-server.enable = true;

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
    enable = true;
    dataDir = "/var/data";

    ssh.enable = true;

    homepage = {
      enable = true; # 8082
      address = "server"; # server or localhost
    };

    # minecraft.enable = false;

    #################
    #   streaming   #
    #################

    plex.enable = true; # 8096 # localhost:32400/web
    tautulli.enable = true; # 8181 plex manager
    # kavita.enable = false;
    komga.enable = true; # 8080 => 8069

    navidrome.enable = true; # 4533

    #################
    #    servarr    #
    #################

    radarr.enable = true; # 7878 movies
    bazarr.enable = true; # 6767 subtitles
    sonarr.enable = true; # 8989 tv series
    lidarr.enable = true; # 8686 music

    prowlarr.enable = true; # 9696 indexer
    # readarr.enable = false; # 8787 books
    # flaresolverr.enable = false; # 8191 bypass cloudflare. down since mid 2024

    ################
    #    backup    #
    ################

    borg.enable = true;
    restic.enable = false; # 8000
    # rsyncd.enable = true;
    filebrowser.enable = true; # 8080 => 8888
    immich.enable = true; # 2283

    git = {
      enable = true;

      # "gitweb" (/gitweb), "cgit" (/cgit), "gitea" (:3000), null
      webUI = "gitea";
      daemon.enable = false; # 9418
      # repoDir = "/var/www/git";
    };

    syncthing = {
      enable = true; # 8384
      extraSyncDirs = false;
    };

    ####################
    #    monitoring    #
    ####################

    # grafana.enable = false; # 3000 => 3002
    # prometheus.enable = false; # 9090
    # loki.enable = false; # 3100 # broken. 2/2025

    #################
    #    DNS/VPN    #
    #################

    unbound.enable = true; # 5335
    adguard.enable = true; # 3000

    bind.enable = false;
    wireguard.enable = false;

    ####################
    #    containers    #
    ####################

    k3s.enable = false;
    podman.enable = false;

    #####################
    #    downloaders    #
    #####################

    # deluge.enable = true; # 8112. default: deluge
    # transmission.enable = true; # 9091. webui 403 with flood

    # give full access with 0.0.0.0/0 subnet
    # default: admin and see systemctl status for password
    qbittorrent-nox.enable = true; # 8080

    # rtorrent.enable = true; # ?
    # rutorrent.enable = true; # ?
    # flood.enable = true; # 3000 => 3001

    # repo archived
    # nzbget.enable = true; # 6789. default: nzbget/tegbzn6789
    # sabnzbd.enable = true; # 8080. port conflict with qbittorrent. config can't change port yet

    # try nicotine-plus instead
    # slskd.enable = true; # 5030

    ###############
    #    proxy    #
    ###############

    caddy.enable = true; # 2019 (default admin port) + 2015/2016 (test)
  };

  #------------------------#
  #            USER             #
  #------------------------#

  user = {
    enable = true;
    prince.enable = true;
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

        qbittorrent.enable = false;
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
