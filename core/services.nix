{ pkgs, user, ... }:

{
  # TODO  SSH
  # https://nixos.wiki/wiki/SSH_public_key_authentication

  ################
  #   SERVICES   #
  ################

  # adb for android interactions ("adbusers")
  # programs.adb.enable = true;
  services.gvfs.enable = true;
  
  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;

    ##############
    #   KEYMAP   #
    ##############

    # Configure keymap in X11
    layout = "fr";
    xkbVariant = "";
    xkbOptions = "ctrl:nocaps"; # caps lock as ctrl
    # "ctrl:swapcaps"; # swap control and shift
    # More xkbOptions with man xkeyboard-config or at https://gist.github.com/jatcwang/ae3b7019f219b8cdc6798329108c9aee
    
    #######################
    #   DISPLAY MANAGER   #
    #######################

    # Default session 
    displayManager = {
      defaultSession = "none+xmonad";
      
      # Light Display Manager
      lightdm.enable = true;

      # greeters.slick = {
      # enable = true;
      # font.name/package theme.name/package iconTheme.name/package extraConfig draw-user-backgrounds
      # };
      
      # Enable sticky keys at startup
      # sleep 3 && xkbset bell sticky -twokey -latchlock feedback led stickybeep &
      # sleep 5 && sticky &
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
