{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.core.system-packages;
  corecfg = config.core;
in {
  options.core.system-packages = {
    enable = mkEnableOption "Core packages required by a (userless) system";
  };

  config = mkIf (corecfg.enable && cfg.enable) {
    # List packages installed in system profile. To search, run: $ nix search wget
    # nano is installed by default

    # Allow unfree packages
    # nixpkgs.config.allowUnfree = true;
    nixpkgs.config = {
      # allowUnfree = true; # vscode

      permittedInsecurePackages = [
        "aspnetcore-runtime-6.0.36"
        "dotnet-core-combined"
        "dotnet-sdk-6.0.428"
        "dotnet-sdk-wrapped-6.0.428"
        "dotnet-sdk-7.0.410"
      ];

      allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
          "aseprite"
          "bitwig-studio"
          # "minecraft-launcher"
          "minecraft-server"
          # "optifine" # minecraft
          # "obsidian"
          "opera"
          "plexmediaserver"
          "reaper"
          # "rider"

          # steam-run
          "steam-run"
          "unrar"
          # "steam-original"
          "steam-unwrapped"
          # "teams"

          "code"
          "vscode-extension-ms-dotnettools-csdevkit"

          # "unfree"
          "vital"
          "vscode"
          # "plexmediaserver"
          # "gitkraken"
          # "Oracle_VM_VirtualBox_Extension_Pack"
        ];

      # unfreePredicate is more precise than unfreeLicenses
      # allowlistedLicenses = with lib.licenses; [
      # virtualbox-puel
      # unfree # aseprite and too many others
      # obsidian
      # unfreeRedistributable # steam-run and too many others
      # ];

      # permittedInsecurePackages = [
      # "electron-25.9.0" # obsidian

      # "vscode-1.86.2"
      # "unfree"
      # ];
    };

    # # avoid removing packages used by nix-shell / flakes
    # nix.extraOptions = ''
    #   keep-outputs = true
    #   keep-derivations = true
    #   '';

    services.emacs = {
      enable = true;
      startWithGraphical = true;

      package = with pkgs;
        ((emacsPackagesFor emacs30).emacsWithPackages
          # (epkgs: with epkgs; [ # adds epkgs prefix to all
          (epkgs: [
            # does not provide the package itself but the binary
            epkgs.vterm
            epkgs.jinx
            epkgs.auctex

            # mu does not install mu4e automatically anymore
            # pkgs.mu
            # epkgs.mu4e
            # pkgs.emacs-lsp-booster

            # tree-sitter-langs # maybe deprecated
            epkgs.treesit-grammars.with-all-grammars
          ]));
    };

    environment.systemPackages = with pkgs; [
      ################
      #   COMMANDS   #
      ################

      brightnessctl
      # btop # top/htop improved
      dash
      # feh
      gh # github
      git
      gnumake
      i3lock # brightnessctl -s set 5 && i3lock -ueni ~/Pictures/gem_full.png; brightnessctl -r
      # inxi
      killall
      ntfs3g # mount ssd with read/write permission
      pamixer
      pavucontrol # microphone
      # pulseaudio
      xautolock
      # xidlehook
      xkbset # key bindings / sticky keys
      # xkb-switch # switch to the next xkb layout
      wget
      wmctrl # for eww workspaces
      unzip

      #############
      #   TOOLS   #
      #############

      arandr # hdmi
      nemo
      pix
      evince # already installed
      gnome-system-monitor
      libgnomekbd # display a given keyboard layout
      vlc

      # libsForQt5.dolphin   
      # cinnamon.cinnamon-screensaver # slow
      # colemak-dh # efficient keyboard layout
      # firefox
      # networkmanager # already installed
      # networkmanager-dmenu # requires dmenu 
      # xorg.xkbcomp # to generate a custom xkb layout

      # wlr-randr # for qtile until a fix is found

      ######################
      #   NixOS-COMMANDS   #
      ######################

      # nixos-option # get access to configuration data

      #################
      #   TERMINALS   #
      #################

      # gnome.gnome-terminal
      # xterm

      ##################
      #  TEXT EDITORS  #
      ##################

      # gnupg # encryption
      # pinentry # passphrase interface

      # broken in NixOS (sept 2023). temporary fix below to get the basic dicts. For better fixes, see below again between parentheses
      # echo "dict-dir /run/current-system/sw/lib/aspell" >> ~/.aspell.conf # file contains: dict-dir /run/current-system/sw/lib/aspell
      # aspell # emacs spell checker
      # aspellDicts.en # aspell english dictionary
      # aspellDicts.fr # aspell french dictionary
      (aspellWithDicts (dicts: with dicts; [ fr en ])) # for jinx

      # mg # emacs like small editor
      # neovim
      # vim
      xed-editor
      # lem # inspired by emacs but written in CL. only available as flake
      # nano # already installed
    ];

    ##############
    #   nanorc   #
    ##############

    # smooth option unknown in leftwm

    # programs.nano.nanorc = ''
    #   set mouse
    #   set autoindent
    #   set softwrap
    #   set tabstospaces
    #   set tabsize 4
    #   set linenumbers  
    # '';

    #############
    #   FONTS   #
    #############

    fonts = {
      enableDefaultPackages = true;

      packages = with pkgs; [
        emacs-all-the-icons-fonts

        # note: nerdfonts have been split in subpackages like nerd-fonts.ubuntu
        # nerdfonts # nerd icons take 6gb
        # (nerdfonts.override { fonts = [ "" "" ]; })

        # roboto-mono
        fira-code
        cascadia-code
        meslo-lgs-nf

        # # rofi fonts:
        # grapenuts-regular
        # icomoon-feather
        # iosevka-nerd-font-complete
        # jetbrains-mono-nerd-font-complete
      ];
    };

    # for emacs cape-dict
    environment.wordlist = {
      # $WORDLIST
      enable = true;

      lists = {
        WORDLIST = [ "${pkgs.scowl}/share/dict/words.txt" ]; # default
        #   AUGMENTED_WORDLIST = [
        #     "${pkgs.scowl}/share/dict/words.txt"
        #     "${pkgs.scowl}/share/dict/words.variants.txt"
        #     (builtins.toFile "extra-words" ''
        #       desynchonization
        #       oobleck'')
        #   ];
      };
    };

  };
}
