{ config, pkgs, bitwig, user, ... }:

{
  # add zsh to /etc/shells
  environment.shells = with pkgs; [ zsh ];

  # adb for android interactions ("adbusers")
  # programs.adb.enable = true;

  services.gvfs.enable = true;

  # Define a user account
  # Do not forget to set a password with ‘passwd’

  ############
  #   USER   #
  ############

  users.users.${user} = {
    
    isNormalUser = true;
    description = "${user}";
    extraGroups = [ "networkmanager" "wheel"];
    shell = pkgs.zsh; # set user's default shell

    
    packages = with pkgs; [
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

      ###########
      #   CLI   #
      ###########

      # sudo cd /mnt && jmtpfs android && nemo android 
      jmtpfs # alt: go-mtpfs or services.gvfs.enable = true;
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
      home-manager

      ##############
      #   RICING   #
      ##############

      # eww # too early
      polybar
      # pywal # not necessary
      rofi
      # rofi-power-menu # replace later with rofi theme
      # taffybar
      # xmobar

      ############
      #   TEST   #
      ############

      bitwig.bitwig-studio # version 3.3.x

      # yabridge
      # yabridgectl
      
      # Install wine, yabridge and vst later
    ];

  };
}

  ###############
  #     NEXT    #
  ###############

  # SSH
  # Touch Typing
  # V. Data science

  # Later => slick screensaver still in unstable. pick it later

  # Good enough (dealt with elisp) => dunst 20mn message
  # Good enough => p10k config is impure => XMonad set to only spawn kitty
  # Good enough => Android connect UBS
  # Good enough => Put everything in home.nix => firefox/opera, telegram, keepass, qBit, nemo, vlc  

  #######################
  #   PREFERRED FILES   #
  #######################

  # TODO
  # home-manager has xdg.mimeApps.defaultApplications
  # If you don't want to use home-manager, you can manually edit .config/mimeapps.list

  ############
  #   MISC   #
  ############

  # For dunst (see home manager manual)
  # xsession.enable = true;
  # xsession.windowManager.command = "…";

  ###########
  #   ZSH   #
  ###########

  # some zsh built-in features
  # compinit: A power completion framework
  # promptinit: prompt framework, with interactive preview
  # vcs_info: integration with every version control system
  # autoload: Support for lazy module loading
  # zstyle: context aware configuration
