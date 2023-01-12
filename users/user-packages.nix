{ config, pkgs, user, ... }:

{
  users.users.${user}.packages = with pkgs; [
    
    ############
    #   APPS   #
    ############
    
    aseprite
    darktable
    gnome.file-roller
    gnome.gnome-disk-utility
    godot
    # kazam # screen recording
    # libsForQt5.kdenlive # video editing
    keepassxc
    krita
    libreoffice
    networkmanagerapplet
    opera
    qbittorrent
    tdesktop
    teams

    # virtual box should rather be added from system packages
    # virtualbox # unneeded => "host.enable" suffices

    ##############
    #   VSCODE   #
    ##############

    # vscode
    # vscode-with-extensions
    
    #################
    #   TERMINALS   #
    #################

    # alacritty
    # kitty
    # wezterm

    ############
    #   MAIL   #
    ############

    # meson # python build
    mu # mail utilities
    notmuch # mail indexer
    offlineimap
    
    ###########
    #   CLI   #
    ###########

    # sudo cd /mnt && jmtpfs android && nemo android 
    jmtpfs # alt: go-mtpfs or services.gvfs.enable = true;
    # libnotify # notify-send. alternative to dunstify
    neofetch
    pandoc
    # telegram-cli # does not work
    tmux
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
    zip

    #########################
    #   IMPROVED COMMANDS   #
    #########################

    bat # cat
    bottom # top
    # choose # cut/awk
    # croc # send files
    # delta # git diff (magit)
    # difftastic # diff
    # direnv # environment variables
    du-dust # disk usage
    # duf # disk analysis
    exa # ls
    fd # find
    fzf # alternative: peco
    gdu # disk usage
    hstr # history
    # mcfly # history search. requires setup
    # mosh # stable ssh
    plocate # locate
    # procs # ps
    ranger # alternative: nnn
    ripgrep # grep. combine it with fzf later
    ripgrep-all
    sd # sed/awk
    thefuck # corrector
    tldr # man
    tlp # battery life
    # wtf # terminal dashboard
    # xh # curl
    # xsv # manipulate csv
    zoxide # cd
    
    ####################
    #   HOME MANAGER   #
    ####################

    # Each time ~/.config/nixpkgs/home.nix changes, run:
    # home-manager switch
    # home-manager

    ##############
    #   RICING   #
    ##############

    eww
    # eww-wayland # wayland variant
    
    polybar
    yad # polybar calendar dependency
    xdotool # polybar calendar dependency
    
    # pywal # not necessary
    rofi
    wofi
    # rofi-power-menu # replace later with rofi theme
    # swaylock # did not work well last time I tried
    # taffybar
    waybar
    # xmobar

    #############
    #   MUSIC   #
    #############

    bitwig-studio
    reaper # Hack with reapack, sws extension
    yabridge
    yabridgectl
    # wine
    # wine64
    # wine64Packages.stagingFull # does not work yet

    # support 64-bit only
    # (wine.override { wineBuild = "wine64"; })
    wine # changed with an overlay to fix it in NixOS 22.05/11
    winetricks # useful to get gdiplus for serum
  ];

  nixpkgs.overlays = [
    (self: super: {
      wine = super.wineWowPackages.stable;
    })
  ];  
}
