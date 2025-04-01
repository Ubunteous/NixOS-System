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
      ############
      #   APPS   #
      ############

      # minecraft # broken
      prismlauncher # minecraft + lambdynamic mod
      # optifine # minecraft
      # nicotine-plus
      tdesktop
      # bookworm # ebook reader
      # kazam # screen recording. maybe broken, try simplescreenrecorder
      # libsForQt5.kdenlive # video editing
      # kmag # magnifier. alt: xzoom, xmag
      # libreoffice
      # logseq
      # miniflux # rss
      # (opera.override { proprietaryCodecs = true; }) # fix videos
      # qbittorrent
      # screenkey # show keys pressed on screen
      # teams # unmaintained as of 29-9-2023
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

      ###############
      #   SOFTENG   #
      ###############

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

      ##############
      #   DEVOPS   #
      ##############

      # # Kubernetes. alt: minikube, minik8s
      # k3s
      # k3d
      # kind

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

      ################
      #   SECURITY   #
      ################

      # crowdsec
      # authentik

      ##############
      #   VSCODE   #
      ##############

      # vscode
      # vscode-with-extensions

      ############
      #   MAIL   #
      ############

      # currently moving this to home manager
      # mu # mail utilities
      # notmuch # mail indexer
      # offlineimap

      # use these commands to create a key and encrypt file
      # gpg --full-generate-key => gpg --symmetric <file> => gpg --decrypt <file>
      # gnupg # requires gpg-agent.enable = true;
      # pinentry # gpg interface
      pinentry-gtk2 # gpg (gtk flavour)

      ###########
      #   CLI   #
      ###########

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
      # zip

      #############################
      #     IMPROVED COMMANDS     #
      #############################

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
      # dogdns # doggo # dig
      du-dust # disk usage
      # duf # disk analysis
      # exa # unmaintained 9-2023 ls replacement
      # eza # ls
      fd # find
      fzf # alternative: peco
      # gdu # disk usage
      # glances # top
      # gping # ping
      # gtop # top
      # hexyl # hexa viewer
      hstr # history
      # httm # zfs/restic time machine
      # httpie # http client
      # hyperfine # benchmark
      # jq # json sed
      # just # make
      # lsd # ls superset
      # mcfly # history search. requires setup
      # mosh # stable ssh
      # most # more than less
      # navi # help
      # plocate # locate
      # procs # ps
      # ranger # alternatives: nnn, joshuto
      # ripgrep # grep. combine it with fzf later
      # ripgrep-all # broken in unstable (September 2023)
      # sd # sed/awk
      # thefuck # corrector
      tldr # man
      # tlp # battery life
      # uutils-coreutils # rust coreutils
      # wtf # terminal dashboard
      # xh # http
      # xsv # manipulate csv
      # zellij # multiplexer+
      # zoxide # cd

      ####################
      #   HOME MANAGER   #
      ####################

      # Each time ~/.config/nixpkgs/home.nix changes, run:
      # home-manager switch
      # home-manager

      ##############
      #   RICING   #
      ##############

      # eww
      # eww-wayland # wayland variant
      # xdotool # job mode
      # rofi # history sorted by frequency in ~/.cache/rofi3.(d)runcache

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
    ];

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

