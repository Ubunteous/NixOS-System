{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.core.misc;
  corecfg = config.core;
in {
  options.core.misc = { enable = mkEnableOption "Add misc configs/services"; };

  config = mkIf (corecfg.enable && cfg.enable) {
    #######
    # NIX #
    #######

    nix.settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      # max-jobs = 6; # see --max-jobs for nixos-rebuild
      # cores = 6;
    };

    #################
    # DOCUMENTATION #
    #################

    # documentation.man = {
    #   # enable = true; # default

    #   # generateCaches = true; # enables apropos(1)/man -k
    # };

    ############
    # TERMINAL #
    ############

    environment = {
      # Warning: NixOS assumes that Bash is used by default for /bin/sh
      # Dash is faster than bash
      binsh = "${pkgs.dash}/bin/dash";

      # make keepassxc and vlc fonts bigger
      # sessionVariables = {
      variables = {
        "QT_SCALE_FACTOR" = "1.25";

        # :dark will fix file-roller which defaults to a white theme
        # seems to work in the terminal but not here
        # export GTK_THEME=Arc-Dark:dark
        "GTK_THEME" = "Arc-Dark:dark";

        # coloured man pages
        "MANROFFOPT" = "'-c'";
        "MANPAGER" = "/bin/sh -c 'col -bx | bat -p -l man'";
        # "MANPAGER" = "/bin/sh -c 'col -bx | bat -p -l man --theme=Monokai'";
      };
    };

    # gpg encryption
    # programs.gnupg.agent.enable = true;
    # services.pcscd.enable = true;

    #######
    # SSH #
    #######

    # no ugly askpass gui anymore with git
    programs.ssh.askPassword = "";

    # # Enable the OpenSSH daemon.
    # services.openssh = {
    #   enable = true;

    #   # openFirewall = true; # defaults to true

    #   # settings = {
    #   #   # LogLevel = "INFO";
    #   #   # DenyUsers = [ "" ];
    #   #   # DenyGroups = [ "" ];
    #   #   # AllowUsers = [ "" ];
    #   #   # AllowGroups = [ "" ];
    #   #   # ports = [ 22 ];
    #   # };

    #   # # use man ssh_config to get the full list
    #   # extraConfig = ''
    #   #   # ConnectionAttemps # defaults to 1
    #   #   # ConnectTimeout

    #   #   # execute a command upon connection on the local/remote machine
    #   #   # LocalCommand
    #   #   # RemoteCommand

    #   #   # LogLevel # Many including INFO, VERBOSE, DEBUG
    #   #   # NoHostAuthenticationForLocalhost # defaults to NO
    #   #   # NumberOfPasswordPrompts # defaults to 3 before giving up
    #   #   # PasswordAuthentication # defaults to YES
    #   #   # Port # defaults to 22
    #   #   # RevokedHostKeys # prevent these keys to be used anymore
    #   #   # StrictHostKeyChecking # do not add automatically keys to ~/.ssh/known_hosts
    #   #   # User # User to log in as 
    #   # '';
    # };

    ################
    # LOCALISATION #
    ################

    i18n.defaultLocale = "en_GB.UTF-8";
    time.timeZone = "Europe/Paris";

    ##########
    # THEMES #
    ##########

    # for themes and more (cinnamon/wezterm)
    programs.dconf.enable = true;

    # tty
    console = {
      # enable = true; # true by default. keep it that way

      keyMap = "fr";
      font = "ter-i32b";
      packages = with pkgs; [ terminus_font ];

      # colors = [
      #   "002b36"
      #   "dc322f"
      #   "859900"
      #   "b58900"
      #   "268bd2"
      #   "d33682"
      #   "2aa198"
      #   "eee8d5"
      #   "002b36"
      #   "cb4b16"
      #   "586e75"
      #   "657b83"
      #   "839496"
      #   "6c71c4"
      #   "93a1a1"
      #   "fdf6e3"
      # ];
    };

    #######
    # TLP #
    #######

    # removes error messages related to wifi command
    # may conflict with power-daemon in zfs config
    services.tlp.enable = true;

    #######
    # USB #
    #######

    # adb for android interactions ("adbusers")
    # programs.adb.enable = true;
    services.gvfs.enable = true;

    # auto mount usb device at /run/media/data
    services.udev.extraRules =
      "  ACTION==\"add\", SUBSYSTEMS==\"usb\", SUBSYSTEM==\"block\", ENV{ID_FS_USAGE}==\"filesystem\", RUN{program}+=\"${pkgs.systemd}/bin/systemd-mount --no-block --automount=yes --collect $devnode /run/media/data\"\n";
  };
}
