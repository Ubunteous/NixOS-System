{ user, ... }:

# Options: config, pkgs, lib, modulesPath, inputs, ... 
# Help: man configuration.nix(5) or nixos-help’
{
  ##################
  #     IMPORTS    #
  ##################

  imports = [ ../core ../lab ../users ../wm ../programming ];

  #--------------------#
  #          CORE           #
  #--------------------#

  core = {
    enable = true;

    boot.enable = true;
    boot-laptop.enable = true;
    networking.enable = true;
    zfs.enable = true;

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
  #         LAB          #
  #--------------------#

  lab = {
    enable = true;
    ssh.enable = false;

    # overview. add widgets once enable other services
    homepage = {
      enable = false; # 8082
      # address = "server.local"; # server.local or localhost
    };

    # minecraft.enable = false;

    ##################
    #     multimedia     #
    ##################

    # shiori.enable = false; # 8080 => 2525 bookmarks
    # kavita.enable = false; # 5000 reading server (library)
    # navidrome.enable = false;

    #################
    #     streaming     #
    #################

    # kodi.enable = false; # also defined with home-manager
    # jellyfin.enable = false; # 8096
    # plex.enable = true; # 8096 # localhost:32400/web
    # jellyseer.enable = false; # 5055
    # tautulli.enable = true; # 8181 plex manager

    ###############
    #     servarr    #
    ###############

    radarr.enable = false; # 7878 movies
    bazarr.enable = false; # 6767 subtitles
    sonarr.enable = false; # 8989 tv series
    prowlarr.enable = false; # 9696 indexer

    # readarr.enable = false; # 8787 books
    lidarr.enable = false; # 8686 music

    ##############
    #    backup     #
    ##############

    borg.enable = false;
    restic.enable = false; # 8000
    # syncoid.enable = true;
    # sanoid.enable = true;
    # rsyncd.enable = true;
    # filebrowser.enable = false; # 8080 => 8888
    # immich.enable = true; # 3001

    git = {
      enable = false;

      # "gitweb" (/gitweb), "cgit" (/cgit), "gitea" (:3000), null
      webUI = "gitea";
      daemon.enable = false; # 9418
      # repoDir = "/var/www/git";
    };

    syncthing = {
      enable = true; # 8384
      extraSyncDirs = true;
    };

    ##################
    #     monitoring     #
    ##################

    # grafana.enable = true; # 3000 => 3002
    # prometheus.enable = true; # 9090
    # loki.enable = false;

    ##################
    #     containers     #
    ##################

    k3s.enable = false;
    podman.enable = false;
    # virtualbox.enable = false;

    ###############
    #     DNS/VPN    #
    ###############

    wireguard.enable = false;
    # unbound.enable = false;
    # bind.enable = false;
    adguard.enable = false; # 3000

    # fail2ban.enable = true;
    # authelia.enable = true;

    #################
    #   downloads   #
    #################

    qbittorrent-nox.enable = false;

    #############
    #    proxy     #
    #############

    caddy = {
      enable = false; # 2019 (default admin port)
      # domain = "server.local";
    };

    # traefik.enable = false;
    # nginx.enable = true; # proxyPass set to 3002 like grafana
  };

  #--------------------#
  #         USER         #
  #--------------------#

  user = {
    enable = true;
    prince.enable = true;

    packages.enable = true;

    music.enable = true;

    input-remapper.enable = true; # for minecraft
    # stylix.enable = false;

    visual_art.enable = true;
    visual_art.wacom_kernel = true;
  };

  #--------------------#
  #         HOME         #
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

        # packages = with pkgs; [ reaper ];

        firefox.enable = true; # nur missing without osConfig
        firefox.on-nixos = true;

        # needs nix-ld
        # not necessary now that plugins are packages
        u-he.enable = false;

        git.enable = true;
        mime.enable = true;
        dunst.enable = true;
        picom.enable = true;
        themes.enable = true;
        flameshot.enable = false; # 1/2025. service broken
        xautolock.enable = true;
        redshift.enable = true; # see config for activation
        # kodi.enable = false;

        emacs.enable = false;
        vscode.enable = false;

        nix-direnv.enable = true;
        xdg-user-dir.enable = false;

        terminal = {
          enable = true;

          zsh.enable = true;
          wezterm.enable = true;

          ghostty.enable = true;

          bash.enable = false;
          alacritty.enable = false;

          fish.enable = false;
          kitty.enable = true;

          ssh.enable = false;
        };

        neovim = {
          enable = true;
          distro = "lazy"; # "nix", "lazy" or "Lazy"

          which-key.enable = true;
          appearance.enable = true;
          languages.enable = true;

          search.enable = true;
          utilities.enable = true;
          passive.enable = true;

          git.enable = true;
          lsp.enable = true;

          # completion, format, test, snippet
          misc.enable = true;
        };

        mail = {
          enable = true;
          thunderbird.enable = true;
        };

        dots.enable = true;
      };
    };
  };

  #------------------------#
  #          LANGUAGES        #
  #------------------------#

  languages = {
    enable = true;

    python.enable = true;
    godot.enable = false;
    csharp.enable = true;

    nix.enable = true;
    lua.enable = false;

    c.enable = false;
    # typst.enable = false;
    latex.enable = true;
    haskell.enable = false;

    go.enable = false;
    rust.enable = false;
    java.enable = false;
    postgresql.enable = true;

    javascript = {
      enable = true;
      addTypescript = false;
    };

    guile.enable = false;
    janet.enable = true;
    clojure.enable = true;
    elixir.enable = false;
    common-lisp.enable = false;

    # only adds lsp/fmt/lint
    shell.enable = false;
    scss.enable = true;
    # yaml.enable = true;
  };

  #--------------------#
  #          WM          #
  #--------------------#

  wm = {
    enable = true;

    # none+xmonad/qtile or cinnmon/hyprland
    main = "none+xmonad";
    display_backend = "x11"; # x11 or wayland

    xmonad.enable = true;
    qtile.enable = false;

    cinnamon.enable = false;
    leftwm.enable = false;
    sway.enable = false;
    hyprland.enable = false;
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
  system.stateVersion = "22.05"; # Do not change this value
}
