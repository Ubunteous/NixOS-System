{ config, lib, pkgs, home-manager, user, ... }:

with lib;
let
  cfg = config.home.terminal.bash;
in
{
  options.home.terminal.bash = {
    enable = mkEnableOption "Enable support for Bash";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user} = {
      ############
      #   BASH   #
      ############

      # !/bin/env bash
      programs.bash = {
        shellAliases = {
          sticky = "xkbset bell sticky -twokey -latchlock feedback led stickybeep &";
          powermenu = "/home/${user}/.config/rofi/powermenu.sh";
        };
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
