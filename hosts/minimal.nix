{ config, lib, lenovo-thinkpad-t14s, pkgs, user, home-manager, ... }:

{
  ##############
  # CORE: BOOT #
  ##############

  boot.loader = {
    systemd-boot = {
      enable = true;

      # Only show 2 latests generations on grub
      # rollback with nix profile rollback --to <gen-number>
      configurationLimit = 2;
    };

    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot/efi";
    timeout = 3;
  };

  boot.kernel.sysctl."kernel.sysrq" = 1;
  boot.blacklistedKernelModules = [ "elan_i2c" ]; # lenovo fix touchpad
  hardware.bluetooth.enable = false;

  #################
  # CORE: NETWORK #
  #################

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_GB.utf8";

  ###############
  # CORE: AUDIO #
  ###############

  sound.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  ##################
  # CORE: PACKAGES #
  ##################

  nixpkgs.config.allowUnfree = true;
  services.emacs.enable = true;

  environment.systemPackages = with pkgs; [
    cinnamon.nemo
    git
    gnome.gnome-system-monitor
    vim
    xed-editor
    xorg.xkbcomp # to generate a custom xkb layout
  ];

  fonts = {
    # enableDefaultPackages = true;

    packages = with pkgs;
      [
        # emacs-all-the-icons-fonts
        # nerdfonts
        fira-code
        # cascadia-code
        # meslo-lgs-nf
      ];
  };

  #################
  # CORE: XSERVER #
  #################

  services.xserver = {
    enable = true;
    xkb = {
      options = "ctrl:nocaps";
      layout = "fr-qwerty";

      extraLayouts.fr-qwerty = {
        description = "Qwerty with french numrow and special characters";
        languages = [ "us" ];
        symbolsFile = ../files/keyboard/fr-qwerty.xkb;
      };
    };

    displayManager = {
      defaultSession = "none+xmonad";
      lightdm.enable = true;
      autoLogin.enable = true;
      autoLogin.user = "${user}";
    };

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = haskellPackages: with haskellPackages; [ xmonad ];
    };
  };

  ################
  # CORE: KANATA #
  ################

  services.kanata = {
    enable = true;

    keyboards."laptop" = {
      devices = [ "/dev/input/by-path/platform-i8042-serio-0-event-kbd" ];

      config = builtins.readFile ../files/keyboard/kanata.txt;
    };
  };

  ########
  # USER #
  ########

  users.users.${user} = {
    isNormalUser = true;
    description = "${user}";

    # uinput and input for kmonad and kanata
    extraGroups = [ "networkmanager" "wheel" "uinput" ];

    packages = with pkgs; [ firefox rofi just fzf wezterm ];
  };

  ########
  # HOME #
  ########

  # imports = [ ./audition.nix ];

  ########
  # MISC #
  ########

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;

  programs.dconf.enable = true; # for themes and more

  # removes error messages related to wifi command
  services.tlp.enable = true;

  hardware.enableRedistributableFirmware = true;
  hardware.firmware = [ ];

  system.stateVersion = "22.05"; # Do not change this value
}
