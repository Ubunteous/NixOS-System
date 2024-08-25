{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.user.packages;
  usercfg = config.user;
in {
  options.user.packages = {
    enable = mkEnableOption "Install ubunteous packages";
  };

  config = mkIf (usercfg.enable && cfg.enable) {
    users.users.${user}.packages = with pkgs; [
      ##########
      #   APPS   #
      ##########

      aseprite
      darktable
      gnome.file-roller
      gnome.gnome-disk-utility # gnome-disks
      keepassxc
      krita
      networkmanagerapplet
      tdesktop

      # bookworm # ebook reader
      # kazam # screen recording
      # libsForQt5.kdenlive # video editing
      # kmag # magnifier. alt: xzoom, xmag
      # libreoffice
      # logseq
      # miniflux # rss
      (opera.override { proprietaryCodecs = true; }) # fix videos
      qbittorrent
      # screenkey # show keys pressed on screen
      # teams # unmaintained as of 29-9-2023
      # thunderbird
      # yacreader # cbr/cbz reader

      ###########
      #   KBD   #
      ###########

      # mechanical keyboard configuration
      qmk # A program to help users work with QMK Firmware
      # qmxk_hid # Commandline tool for interactng with QMK devices over HID
      # qmk-udev-rules # Official QMK udev rules list. Necessary for flashing
      # keymapviz # A qmk keymap.c visualizer
      # stable.via # alternative to qmk. unstable is broken
      # vial

      ############
      #   SOFTENG   #
      ############

      # meson
      # mkdocs
      # sphinx
      # zeal
      # watchexec # run command on file change

      # # git interfaces (sorted stating from most complex/powerful)
      # gitkraken # closed source
      # lazygit
      # gitui # best compromise of power/clarity/doc
      # tig

      # lefthook # git hook

      ############
      #   DEVOPS   #
      ############

      # # Kubernetes. alt: minikube, minik8s
      # k3s
      # k3d
      kind

      # vagrant
      # wireshark

      gparted # graphical parted
      # parted
      # rpi-imager
      # ventoy-bin

      # # CONTAINERS
      # buildah
      # skopeo

      # DOCKER_HOST=unix:///run/user/1000/podman/podman.sock lazydocker'
      # lazydocker

      # environment.interactiveShellInit = "alias dive='dive --source podman'";
      # dive # analyse docker image

      ############
      #   VSCODE   #
      ############

      # vscode
      # vscode-with-extensions

      ##########
      #   MAIL   #
      ##########

      # currently moving this to home manager
      # mu # mail utilities
      # notmuch # mail indexer
      # offlineimap

      # use these commands to create a key and encrypt file
      # gpg --full-generate-key => gpg --symmetric <file> => gpg --decrypt <file>
      # gnupg # requires gpg-agent.enable = true;
      # pinentry # gpg interface
      pinentry-gtk2 # gpg (gtk flavour)

      #########
      #   CLI   #
      #########

      # appimage-run # for Pulse downloader (cd dir/ appimage-run NameOfYourImage.AppImage)

      # sudo cd /mnt && jmtpfs android && nemo android 
      jmtpfs # alt: go-mtpfs or services.gvfs.enable = true;

      # libnotify # notify-send. alternative to dunstify
      # neofetch
      # pandoc
      steam-run
      # telegram-cli # does not work
      # traceroute
      # tmux
      unrar

      # How to use wrap for fountain files:
      # 1) List the files needed in a .txt file
      # 2) call rg to find the files needed (ignore comments)
      # Lines which do not start with => "%" "^[^%]+"
      # Lines which start with "%" => "^[%].+"
      # Note: rg -v inverts the lines found
      # 3) pipe the output with xargs cat | wrap pdf
      # rg "^[^%]+" test.txt | xargs cat | wrap pdf
      # wrap # cat file1.fountain file2.fountain | wrap pdf

      # youtube-dl # may be needed later
      # youtube-dlp # fork
      zip

      ########################
      #     IMPROVED COMMANDS     #
      ########################

      bat # cat
      # bottom # top
      # broot # directory tree nav
      cheat # tldr/man
      # choose # cut/awk
      # croc # send files
      # curlie # curl
      # delta # git diff
      # difftastic # diff
      # direnv # environment variables # replaced by nix-direnv
      # dogdns # dig
      du-dust # disk usage
      # duf # disk analysis
      # exa # unmaintained 9-2023 ls replacement
      eza
      fd # find
      fzf # alternative: peco
      gdu # disk usage
      # glances # top
      # gping # ping
      # gtop # top
      hstr # history
      # httpie # http client
      # hyperfine # benchmark
      # jq # json sed
      just # make
      # lsd # ls superset
      # mcfly # history search. requires setup
      # mosh # stable ssh
      # most # more than less
      # plocate # locate
      # procs # ps
      # ranger # alternative: nnn
      ripgrep # grep. combine it with fzf later
      ripgrep-all # broken in unstable (September 2023)
      # sd # sed/awk
      # thefuck # corrector
      tldr # man
      tlp # battery life
      # uutils-coreutils # rust coreutils
      # wtf # terminal dashboard
      # xh # http
      # xsv # manipulate csv
      # zellij # multiplexer+
      # zoxide # cd

      ################
      #   HOME MANAGER   #
      ################

      # Each time ~/.config/nixpkgs/home.nix changes, run:
      # home-manager switch
      # home-manager

      ############
      #   RICING   #
      ############

      eww
      # eww-wayland # wayland variant
      xdotool # job mode
      rofi # history sorted by frequency in ~/.share/rofi3.(d)runcache

      # bars discarded in favour of eww
      # polybar
      # yad # polybar calendar dependency
      # taffybar
      # waybar
      # xmobar
      # pywal # not necessary
      # wofi # rofi still works on wayland
      # rofi-power-menu # replace later with rofi theme
      # swaylock # did not work well last time I tried

      ###########
      #   MUSIC   #
      ###########

      # config.nur.repos.dukzcry.bitwig-studio3 # version 3.1 # deleted and replaced by bitwig 5
      # bitwig-studio # latest
      # bitwig-studio3 # can be modified with overlay

      (callPackage ../pkgs/bitwig3.nix { })

      # (callPackage ../pkgs/reaper.nix {
      #   jackLibrary = null;
      #   libpulseaudio = libpulseaudio; 
      # })

      reaper # Hack with reapack, sws
      # yabridge
      # yabridgectl
      # wine
      # wine64
      # wine64Packages.stagingFull # does not work yet

      # Danger with wine: default wine packages only come with 32 bits support
      # use winewow in an overlay for 64 bits support
      # Moreover, some packages are called wine64 instead of wine
      # (wine.override { wineBuild = "wine64"; })
      # (stable.wine.override { wineBuild = "wine64"; })
      # nixpkgs.overlays = [ (self: super: { wine = super.wineWowPackages.stable; }) ];
      # wine # changed with an overlay to fix it in NixOS 22.05/11
      # stable.wine
      # stable.wineWowPackages.stable
      stable.wineWowPackages.stable
      # winetricks # useful to get gdiplus for serum
      stable.winetricks
      stable.yabridge
      stable.yabridgectl

      # was necessary for native instrument
      # samba
      # samba4Full
    ];

    #############
    #   OVERLAYS   #
    #############

    # necessary to fix wine
    nixpkgs.overlays = [

      ############
      #   WINE   #
      ############

      # opengl support for wine
      # hardware support for wine: hardware.opengl.driSupport32Bit

      (self: super: {
        wine = super.wineWowPackages.stable;
        stable.wine = super.wineWowPackages.stable;
      })

      ###########
      #   BITWIG   #
      ###########

      # BUG: AUDIO ENGINE CRASHING
      # (final: prev:
      #   {
      #     bitwig-studio3 = prev.bitwig-studio3.overrideAttrs (old: {
      #       version = "3.2.8";
      #       src = prev.fetchurl {
      #         url = "https://downloads.bitwig.com/stable/3.2.8/bitwig-studio-3.2.8.deb";
      #         sha256 = "18ldgmnv7bigb4mch888kjpf4abalpiwmlhwd7rjb9qf6p72fhpj";
      #       };

      #       # runtimeDependencies = [ pkgs.pulseaudio pkgs.libjack2 ];
      #     });
      #   })   

    ];

    # (mypackage.overrideAttrs (oldAttrs: rec {
    #   desktopItem = oldAttrs.desktopItem.override {
    #     exec = "/my_exec";
    #     terminal = true;
    #   };
    #   postInstall = builtins.replaceStrings [ "${oldAttrs.desktopItem}" ] [ "${desktopItem}" ] oldAttrs.postInstall;
    # }));

    # requires pinentry and gpg
    # programs.gnupg.agent = {
    #   enable = true;
    # pinentryFlavor = "gtk2";
    # enableSSHSupport = true;
    # };

    # provides most missing udev rules
    hardware.keyboard.qmk.enable = true;
  };
}

