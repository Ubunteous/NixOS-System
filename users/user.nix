{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.user.prince;
  usercfg = config.user;
in {
  options.user.prince = { enable = mkEnableOption "Add principal user"; };

  config = mkIf (usercfg.enable && cfg.enable) {
    # add zsh to /etc/shells
    environment.shells = with pkgs; [ zsh ];

    # potential fix starting from update to 23.05
    programs.zsh.enable = true;

    # users.groups = { uinput = { }; }; # for KMonad

    # Define a user account
    # Do not forget to set a password with ‘passwd’
    users.users.${user} = {
      isNormalUser = true;
      description = "${user}";

      # realtime audio for musnix
      # uinput and input for kmonad and kanata

      extraGroups = [ "networkmanager" "wheel" "uinput" ]
        ++ (if ("${user}" != "server") then [ "realtime" "audio" ] else [ ]);

      shell = pkgs.zsh; # set user's default shell

      packages = with pkgs; [
        file-roller # file-roller
        gnome-disk-utility # gnome-disks
        keepassxc
        networkmanagerapplet
        zip
        eza
        gdu # disk usage
        just # make
        ripgrep # grep. combine it with fzf later
        tlp # battery life
        eww
        # eww-wayland # wayland variant
        rofi # history sorted by frequency in ~/.cache/rofi3.(d)runcache
      ];

      # openssh = {
      #   authorizedPrincipals = [ "example@host" ];
      #   authorizedKeys.keys = [ "keys" ];
      #   authorizedKeys.keyFiles = [ "paths" ];
      # };

      # THESE ARE ALL DEFAULTS
      # createHome = true;
      # home = "/home/${user}";
      # homeMode = "700"; # defaults to "700"
    };
  };
}
