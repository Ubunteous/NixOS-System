{ pkgs, home-manager, user, ... }:

#################
#   FLAMESHOT   #
#################

{
  home-manager.users.${user} = {

    services.flameshot = {
      enable = true;
      settings =
        {
          General =
            {              
              # Whether the savePath is a fixed path
              # savePathFixed = true;

              # Image Save Path
              savePath = "/home/${user}/Pictures/Screenshots";

              # Default file extension for screenshots
              # saveAsFileExtension=.png
              
              # Main UI color
              # uiColor=#740096
            };
        };
    };
  };
}
