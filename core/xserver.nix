{ config, lib, user, pkgs, ... }:

with lib;
let
  cfg = config.core.xserver;
  corecfg = config.core;

  # formats the displayManager.defaultSession string depending on
  # whether it is a windows manager or desktop environment
in {
  options.core.xserver = {
    enable = mkEnableOption "Activate xserver";
    displayManager = mkOption {
      description = "Display Manager used";
      type = types.enum [ "sddm" "gdm" "lightdm" ];
    };
  };

  config = mkIf (corecfg.enable && cfg.enable) {
    programs.i3lock.enable = true;

    services = {
      displayManager = {
        # none+xmonad/qtile or cinnamon
        # defaultSession = "none+${mainwmcfg}";
        defaultSession = config.wm.main;

        # sessionPackages = [ pkgs.qtile-unwrapped ];

        # Enable automatic login for the user.
        autoLogin.enable = true;
        autoLogin.user = "${user}";

        # Enable sticky keys at startup:
        # sleep 3 && xkbset bell sticky -twokey -latchlock feedback led stickybeep &

        sddm = {
          enable = if cfg.displayManager == "sddm" then true else false;
          wayland.enable =
            if config.wm.display_backend == "wayland" then true else false;
        };

        gdm = {
          enable = if cfg.displayManager == "gdm" then true else false;
          wayland = true;
          # debug; settings; autoSuspend; autoLogin.delay;
        };
      };

      xserver = {
        enable = true;

        ##############
        #   KEYMAP   #
        ##############

        # get info on current layout:
        # setxkbmap -query

        # reset to default:
        # setxkbmap -layout "fr" -variant "nodeadkeys,basic"
        # other layouts: gb for uk, au for australia

        # Configure keymap in X11
        # Check layouts with gkbd-keyboard-display -l "gb(colemak)" or fr

        # xkbVariant = ",";
        # grp:shifts_toggle to toggle layouts, compose:ralt
        # More xkbOptions with man xkeyboard-config or at https://gist.github.com/jatcwang/ae3b7019f219b8cdc6798329108c9aee
        xkb = {
          options = "ctrl:nocaps"; # caps lock as ctrl

          layout =
            if config.core.kanata.enable then "fr-qwerty" else "fr-colemak, fr";

          extraLayouts = {
            fr-qwerty = {
              description = "Qwerty with french numrow and special characters";
              languages = [ "us" ];
              symbolsFile = ../files/keyboard/fr-qwerty.xkb;
            };

            fr-colemak = {
              description = "Colemak variant of the FR layout";
              languages = [ "fra" ];
              symbolsFile = ../files/keyboard/fr-colemak.xkb;
            };
          };
        };

        #######################
        #   DISPLAY MANAGER   #
        #######################

        displayManager = {
          lightdm = {
            enable = if cfg.displayManager == "lightdm" then true else false;
            # enable = if config.wm.display_backend == "x11" then true else false;

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

          sessionCommands = ''
            ~/.locker/start-xautolock &
          '';
        };
      };
    };
  };
}
