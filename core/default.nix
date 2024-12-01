{ lib, pkgs, ... }:

# lib.mkIf (config.networking.hostName == "") { imports = [ ../core/lightdm.nix ]; }

with lib; {
  options.core.enable = mkEnableOption "Core configuration";

  imports = [
    ./boot.nix
    ./networking.nix

    ./zfs.nix
    ./sound.nix

    ./xserver.nix
    ./packages.nix

    ./kanata.nix
    ./nix-ld.nix
  ];

  ############
  #   MISC   #
  ############

  config = {
    # adb for android interactions ("adbusers")
    # programs.adb.enable = true;
    services.gvfs.enable = true;

    # auto mount usb device at /run/media/usb
    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEMS=="usb", SUBSYSTEM=="block", ENV{ID_FS_USAGE}=="filesystem", RUN{program}+="${pkgs.systemd}/bin/systemd-mount --no-block --automount=yes --collect $devnode /run/media/usb"       
    '';

    # Configure tty
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

    # no ugly askpass gui anymore with git
    programs.ssh.askPassword = "";

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # gpg encryption
    # programs.gnupg.agent.enable = true;
    # services.pcscd.enable = true;

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
  };
}
