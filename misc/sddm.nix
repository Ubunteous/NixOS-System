{ pkgs, user, ... }:

{
  ################
  #   SERVICES   #
  ################

  services.xserver = {
    enable = true;

    ##############
    #   KEYMAP   #
    ##############

    # Configure keymap in X11 => controlled by wayland compositor
    # left for X11 WM
    layout = "fr";
    xkbVariant = "";
    xkbOptions = "ctrl:nocaps"; # caps lock as ctrl
    
    #######################
    #   DISPLAY MANAGER   #
    #######################

    # Default session 
    displayManager = {
      defaultSession = "none+xmonad";
      
      sddm = {
        enable = true;
        # autoLogin.relogin = true;
        # settings, autoNumlock
        # theme, enableHidpi
        # setupScript, stopScript
        # autoLogin.minimumUid        
      };

      # Enable sticky keys at startup
      sessionCommands = ''~/.locker/start-xautolock &'';
      
      # Enable automatic login for the user.
      # autoLogin.enable = true;
      # autoLogin.user = "${user}";
    };      
  };

  # services.xserver.displayManager.lightdm.background
  
  # Configure console keymap => defined by Wayland compositor
  # left for X11 WM
  console.keyMap = "fr";

  # adb for android interactions ("adbusers")
  # programs.adb.enable = true;
  services.gvfs.enable = true;

  # no ugly askpass gui anymore with git
  programs.ssh.askPassword = "";
}
