{ user, ... }:

# Options: config, pkgs, lib, modulesPath, inputs, ... 
# Help: man configuration.nix(5) or nixos-help’
{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  programs.dconf.enable = true; # for themes and more

  # removes error messages related to wifi command
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
    sound.enable = true;

    xserver.enable = true;
    system-packages.enable = true;

    kanata.enable = true;
    nix-ld.enable = true;
  };

  #--------------------#
  #        LAB         #
  #--------------------#

  lab = {
    enable = true;
    # ssh.enable = true;

    # overview. add widgets once enable other services
    homepage.enable = true; # 8082

    k3s.enable = false;
    podman.enable = true;
    # virtualbox.enable = false;

    # grafana.enable = true; # 3000 => 3002
    # prometheus.enable = true; # 9090
    # loki.enable = false;

    wireguard.enable = false;
    technitium.enable = true;
    adguard.enable = true; # 3000
    # restic.enable = true; # 8000
    syncthing.enable = true; # 8384

    ##################
    #   multimedia   #
    ##################

    # kodi.enable = false; # also defined with home-manager
    jellyfin.enable = true; # 8096
    # jellyseer.enable = false; # 5055
    # shiori.enable = false; # 8080 => 2525

    ###############
    #   servarr   #
    ###############

    radarr.enable = true; # 7878 movies
    bazarr.enable = true; # 6767 subtitles
    sonarr.enable = true; # 8989 tv
    readarr.enable = true; # 8787 books
    lidarr.enable = true; # 8686 music
    prowlarr.enable = true; # 9696 indexer

    #############
    #   proxy   #
    #############

    # caddy.enable = true; # 2019 (default admin port)
    # traefik.enable = false;
    # nginx.enable = true; # proxyPass set to 3002 like grafana
  };

  #--------------------#
  #        USER        #
  #--------------------#

  user = {
    enable = true;

    laptop.enable = true;
    packages.enable = true;
    musnix.enable = true;
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

        kodi.enable = true;

        firefox.enable = true; # nur missing without osConfig
        firefox.on-nixos = true;

        git.enable = true;
        mime.enable = true;
        u-he.enable = true; # needs nix-ld
        dunst.enable = true;
        picom.enable = true;
        themes.enable = true;
        flameshot.enable = true;
        xautolock.enable = true;
        redshift.enable = false; # see config for activation

        emacs.enable = false;
        nix-direnv.enable = true;
        xdg-user-dir.enable = false;

        terminal = {
          enable = true;

          zsh.enable = true;
          wezterm.enable = true;

          bash.enable = false;
          alacritty.enable = false;

          fish.enable = false;
          kitty.enable = false;
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
  #        LANGUAGES       #
  #------------------------#

  languages = {
    enable = true;

    python.enable = true;
    godot.enable = false;

    nix.enable = true;
    lua.enable = false;

    c.enable = true;
    # typst.enable = false;
    latex.enable = true;
    haskell.enable = false;

    go.enable = false;
    rust.enable = false;
    java.enable = false;
    postgresql.enable = false;

    javascript = {
      enable = false;
      addTypescript = false;
    };

    guile.enable = false;
    elixir.enable = false;
    clojure.enable = false;
    common-lisp.enable = false;

    # only adds lsp/fmt/lint
    shell.enable = false;
  };

  #--------------------#
  #         WM         #
  #--------------------#

  wm = {
    enable = true;
    xmonad.enable = true;

    qtile.enable = false;
    cinnamon.enable = false;

    leftwm.enable = false; # => must use polybar
    sway.enable = false; # => has a built-in bar
    hyprland.enable = false; # => must uses waybar
  };

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
