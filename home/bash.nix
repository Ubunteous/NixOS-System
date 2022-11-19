{ pkgs, home-manager, user, ... }:

############
#   BASH   #
############

{
  home-manager.users.${user} = {
    # !/bin/env bash
    programs.bash = {
      shellAliases = {
        sticky = "xkbset bell sticky -twokey -latchlock feedback led stickybeep &";
        powermenu = "/home/${user}/.config/rofi/powermenu.sh";
      };
    };    
  };
}
  
  ######################
  #   COMMON ALIASES   #
  ######################

  # Works with bash only. maybe with others outside home manager
  # environment.shellAliases = {
  #   sticky = "xkbset bell sticky -twokey -latchlock feedback led stickybeep &";
  #   powermenu = "/home/${user}/.config/rofi/powermenu.sh";
  #   polybar = "/home/${user}/.config/polybar/launch.sh";
  # };
