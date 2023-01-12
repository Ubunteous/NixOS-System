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
    layout = "fr";
    xkbVariant = "";
    xkbOptions = "ctrl:nocaps"; # caps lock as ctrl
    
    #######################
    #   DISPLAY MANAGER   #
    #######################

    # Default session 
    displayManager = {
      defaultSession = "none+xmonad";
      
      gdm = {
        enable = true;
        wayland = true;
        # debug; settings; autoSuspend; autoLogin.delay;
      };

      # Enable sticky keys at startup
      sessionCommands = ''~/.locker/start-xautolock &'';
      
      # Enable automatic login for the user.
      autoLogin.enable = true;
      autoLogin.user = "${user}";
    };      
  };

  # services.xserver.displayManager.lightdm.background
  
  # Configure console keymap => defined by Wayland compositor
  console.keyMap = "fr";

  # adb for android interactions ("adbusers")
  # programs.adb.enable = true;
  services.gvfs.enable = true;

  # no ugly askpass gui anymore with git
  programs.ssh.askPassword = "";
}
