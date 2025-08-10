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

      # (opera.override { proprietaryCodecs = true; }) # fix videos
      # bookworm # ebook reader
      # kazam # screen recording. maybe broken, try simplescreenrecorder
      # kmag # magnifier. alt: xzoom, xmag
      # libreoffice
      # libsForQt5.kdenlive # video editing
      # logseq
      # minecraft # broken
      # miniflux # rss
      # nyxt ;; deps notify broken. 4/2025
      # optifine # minecraft
      # prismlauncher # minecraft + lambdynamic mod
      # qbittorrent
      # screenkey # show keys pressed on screen
      tdesktop
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

      # cd: zoxide
      # comma: nix-shell -p
      # ls: eza, exa, lsd
      # dns: dogdns, doggo, dig
      # http: httpie, xh, curlie (curl)
      # ping: gping
      # hexa: hexyl
      # choose # cut/awk
      # disk analysis: gdu/du-dust/duf
      # top/ps: procs, glances, gtop, bottom
      # browser: ranger, nnn, joshuto
      # data editor: sd (stream), jq (json), xsv (csv)
      # grep: ripgrep, ripgrep-all # broken in unstable (September 2023)
      # diff: difftastic, delta

      # misc:
      # plocate # locate
      # mosh # stable ssh
      # croc # send files
      # thefuck # corrector
      # most # more than less
      # zellij # multiplexer+
      # hyperfine # benchmark
      # wtf # terminal dashboard
      # broot # directory tree nav
      # direnv # environment variables # replaced by nix-direnv

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

