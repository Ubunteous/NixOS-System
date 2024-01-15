{ user, ... }:

{  
  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;

    ####################
    #      XRANDR      #
    ####################

    # virtualScreen = {
    #   x = 1920;
    #   y = 1080;
    # };

    # xrandrHeads = [
    #   "Home"
    #   {
    #     output = "eDP-1";
    #     primary = true;
    #     monitorConfig = "Option \"Disable\" \"true\"";
    #   }
    #   {
    #     output = "HDMI-1";
    #     primary = false;
    #   }
    # ];
    
    ####################
    #   KEYMAP : KBD   #
    ####################

    # get info on current layout:
    # setxkbmap -query

    # reset to default:
    # setxkbmap -layout "fr" -variant "nodeadkeys,basic"

    # Configure keymap in X11
    # Check layouts with gkbd-keyboard-display -l "gb(colemak)" or fr
    # layout = "fr-colemak, fr";
    # xkbVariant = ",";
    # grp:shifts_toggle to toggle layouts, compose:ralt
    # xkbOptions = "ctrl:nocaps"; # caps lock as ctrl
    
    # "ctrl:swapcaps"; # swap control and shift
    # More xkbOptions with man xkeyboard-config or at https://gist.github.com/jatcwang/ae3b7019f219b8cdc6798329108c9aee
    
    # extraLayouts.fr-colemak = {
    #   description = "Colemak variant of the FR layout";
    #   languages   = [ "fra" ];
    #   symbolsFile = ../files/fr-colemak.xkb;
    # };

    ################################
    #   KEYMAP : KMONAD / KANATA   #
    ################################

    layout = "fr-qwerty";

    xkbOptions = "ctrl:nocaps"; # caps lock as ctrl

    extraLayouts.fr-qwerty = {
      description = "Qwerty with french numrow and special characters";
      languages   = [ "us" ];
      symbolsFile = ../../files/fr-qwerty.xkb;
    };

    #######################
    #   DISPLAY MANAGER   #
    #######################

    # Default session 
    displayManager = {
      defaultSession = "none+xmonad";
      
      # Light Display Manager
      lightdm = {
        enable = true;
        # background = "/home/ubunteous/Pictures/sky.jpg";

        greeters.slick = {
          enable = true;
          # NixOS reads the wallpaper in $HOME/.background-image/<background.jpg>
          # draw-user-backgrounds = true; # ignored by NixOS ?

          # creates a second background variable which clashes with the default one
          extraConfig = ''
           draw-grid=true
           '';
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
      sessionCommands = ''
        ~/.locker/start-xautolock &
      '';
      
      # Enable automatic login for the user.
      autoLogin.enable = true;
      autoLogin.user = "${user}";
    };

    # services.xserver.displayManager.lightdm.background
  };

  # Whether to enable the Wacom touchscreen/digitizer/tablet.
  # services.xserver.wacom.enable = true;

  # Configure console keymap
  console.keyMap = "fr";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;


  # List services that you want to enable:

  # no ugly askpass gui anymore with git
  programs.ssh.askPassword = "";

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
}
