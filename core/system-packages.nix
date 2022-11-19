{ pkgs, ... }:

{
  # List packages installed in system profile. To search, run: $ nix search wget
  # nano is installed by default
  # find new packages with nix-env -qaP 'name'

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  environment.systemPackages = with pkgs; [

    ################
    #   COMMANDS   #
    ################

    brightnessctl
    # feh
    gh # github
    git
    # btop # top/htop improved
    i3lock # brightnessctl -s set 5 && i3lock -ueni ~/Pictures/gem_full.png; brightnessctl -r
    # inxi
    killall
    pamixer
    # pulseaudio
    xautolock
    xkbset # key bindings / sticky keys
    wget

    #############
    #   TOOLS   #
    #############

    cinnamon.nemo
    cinnamon.pix
    # cinnamon.cinnamon-screensaver # slow    
    evince # already installed
    firefox
    gimp
    gnome.gnome-system-monitor
    # networkmanager # already installed
    vlc

    ######################
    #   NixOS-COMMANDS   #
    ######################

    nixos-option # get access to configuration data

    #################
    #   TERMINALS   #
    #################

    gnome.gnome-terminal
    # xterm

    ##################
    #  TEXT EDITORS  #
    ##################

    #emacs
    ((emacsPackagesFor emacs).emacsWithPackages (epkgs: [
      epkgs.vterm
    ]))
    
    aspell # emacs spell checker
    aspellDicts.en # aspell english dictionarxsxcy
    aspellDicts.fr # aspell french dictionary

    # neovim
    vim
    xed-editor
    nano # already installed
  ];

  
  ##############
  #   nanorc   #
  ##############

  # smooth option unknown in leftwm
  
  programs.nano.nanorc = ''
  set mouse
  set autoindent
  set softwrap
  set tabstospaces
  set tabsize 4
  set linenumbers  
  '';

  #############
  #   FONTS   #
  #############

  fonts = {
    enableDefaultFonts = true;

    fonts = with pkgs; [
      emacs-all-the-icons-fonts
      nerdfonts

      # roboto-mono
      fira-code
      cascadia-code
      # (nerdfonts.override { fonts = [ "" "" ]; })
      meslo-lgs-nf
      # rofi fonts:
      # grapenuts-regular
      # icomoon-feather
      # iosevka-nerd-font-complete
      # jetbrains-mono-nerd-font-complete
    ];
  };
}
