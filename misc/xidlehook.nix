{ pkgs, home-manager, user, ... }:

#################
#   XIDLEHOOK   #
#################

{
  home-manager.users.${user} = {
    services.xidlehook = {
      enable = true;

      # detect if wake from sleep to reset timer
      # detect-sleep = true;

      # disable locking when audio is playing
      # not-when-audio = true;

      # disable locking when an app is fullscreen
      # not-when-fullscreen = true;

      # execute the program once and exit
      once = true;

      # delay: time before executing the command.
      # command: executed after the idle timeout is reached.
      # canceller: executed when the user becomes active again (between two timer activations)
      timers = [
        {
          delay = 5;
          command = "dunstify \"Test\"";
          canceller = "nemo";
          
          # command = "xrandr --output \"$PRIMARY_DISPLAY\" --brightness .1";
          # canceller = "xrandr --output \"$PRIMARY_DISPLAY\" --brightness 1";
        }
        {
          delay = 15;
          command = "alacritty";
          canceller = "dunstify AAA";
          
          # command = ''
          #   brightnessctl -s set 5
          #   i3lock -ueni ~/Pictures/gem_full.png
          #   brightnessctl -r
          # '';
        }
      ];
      
      # environment = { "primary-display" = "$(xrandr | awk '/ primary/{print $1}')"; };
    };
  };
}
