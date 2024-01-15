{ config, lib, user, ... }:

with lib;
let
  cfg = config.core.xserver;
  corecfg = config.core;
in
{
  options.core.xserver = {
    enable = mkEnableOption "Activate xserver";
  };

  config = mkIf (corecfg.enable && cfg.enable) {
    services.xserver = {
      # Enable the X11 windowing system.
      enable = true;

      ##############
      #   KEYMAP   #
      ##############

      # get info on current layout:
      # setxkbmap -query

      # reset to default:
      # setxkbmap -layout "fr" -variant "nodeadkeys,basic"

      # Configure keymap in X11
      # Check layouts with gkbd-keyboard-display -l "gb(colemak)" or fr

      # xkbVariant = ",";
      # grp:shifts_toggle to toggle layouts, compose:ralt
      # More xkbOptions with man xkeyboard-config or at https://gist.github.com/jatcwang/ae3b7019f219b8cdc6798329108c9aee
      xkbOptions = "ctrl:nocaps"; # caps lock as ctrl

      layout = if config.core.kanata.enable then "fr-qwerty" else "fr-colemak, fr";

      extraLayouts = {
        fr-qwerty = {
          description = "Qwerty with french numrow and special characters";
          languages   = [ "us" ];
          symbolsFile = ../files/fr-qwerty.xkb;
        };

        fr-colemak = {
          description = "Colemak variant of the FR layout";
          languages   = [ "fra" ];
          symbolsFile = ../files/fr-colemak.xkb;
        };
      };

      #######################
      #   DISPLAY MANAGER   #
      #######################

      # displayManager = if (! cfg.wayland.enable) then { lightdm.enable = true; } else { gdm.enable = true; gdm.wayland = true; };
      displayManager = {
        lightdm = {
          enable = true;
          # wayland = true; # option available for gdm 
          # background = "/home/ubunteous/Pictures/sky.jpg";

          greeters.slick = {
            enable = true;
            # NixOS reads the wallpaper in $HOME/.background-image/<background.jpg>
            # draw-user-backgrounds = true; # ignored by NixOS ?

            # creates a second background variable which clashes with the default one
            extraConfig = "draw-grid=true";
            # background-color=#772953

            # theme = {
            #   name = "Arc-Dark";
            #   package = pkgs.arc-theme;
            # };

            # iconTheme = {
            #   name = "Papirus-Dark";
            #   package = pkgs.papirus-icon-theme;
            # };

            # font = {
            #   name = "Noto Sans";
            #   package = pkgs.noto-fonts;
            # };
          };
        };

        # Enable sticky keys at startup:
        # sleep 3 && xkbset bell sticky -twokey -latchlock feedback led stickybeep &
        sessionCommands = "~/.locker/start-xautolock &";

        # Enable automatic login for the user.
        autoLogin.enable = true;
        autoLogin.user = "${user}";
      };
    };
  };
}
