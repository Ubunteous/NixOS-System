{ config, lib, pkgs, user, ... }:

with lib;
let
  cfg = config.home.terminal.bash;
  homecfg = config.home;
in
{
  options.home.terminal.bash = {
    enable = mkEnableOption "Enable support for Bash";
  };

  config = mkIf (homecfg.enable && cfg.enable) {
    ############
    #   BASH   #
    ############

    # overwrite .bashrc if already there
    home.file.".bashrc".force = true;
    
    # !/bin/env bash
    programs.bash = {
      enable = true;
      
      shellAliases = {
        sticky = "xkbset bell sticky -twokey -latchlock feedback led stickybeep &";
        # powermenu = "${config.home.homeDirectory}/.config/rofi/powermenu.sh";
      };
      
      bashrcExtra = ''
          PS1='\[\e[38;5;177m\]>>> \[\e[38;5;69m\]\w\[\e[0m\] '
        '';
    };
  };
}
  
  ######################
  #   COMMON ALIASES   #
  ######################

  # Works with bash only. maybe with others outside home manager
  # environment.shellAliases = {
  #   sticky = "xkbset bell sticky -twokey -latchlock feedback led stickybeep &";
  #   polybar = "${config.home.homeDirectory}/.config/polybar/launch.sh";
  # };
