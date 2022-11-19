{ pkgs, home-manager, user, ... }:

############
#   FISH   #
############

{
  home-manager.users.${user} = {
    programs.fish = {
      enable = true;

      shellAbbrs = {
        sticky = "xkbset bell sticky -twokey -latchlock feedback led stickybeep";
        powermenu = "/home/${user}/.config/rofi/powermenu.sh";
        gem-lock = "brightnessctl -s set 5 && i3lock -ueni ~/Pictures/gem_full.png; brightnessctl -r";
      };
      
      functions = {
        fish_greeting = ""; # no greeting

        fish_prompt = {
          body = ''
                   set -l textcol purple
                   set -l arrowcol green
                   set_color $textcol # -b $bgcol
                   echo -n ""(basename $PWD)" "
                   set_color $arrowcol -b normal
                   echo -n " "
                '';
        };
      };
    };
  };
}
