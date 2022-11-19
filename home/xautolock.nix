{ pkgs, home-manager, user, ... }:

#################
#   XAUTOLOCK   #
#################

{
  # exec --no-startup-id ~/bin/start-xautolock
  # ~/.locker/start-xautolock &
  home-manager.users.${user} = {
    home.file.".locker/start-xautolock" = {
      text = ''
      ${pkgs.xautolock}/bin/xautolock \
                -time 5 \
                -locker "brightnessctl -s set 5 && i3lock -ueni ~/Pictures/gem_full.png; brightnessctl -r" \
                -notify 55 \
                -notifier "${pkgs.libnotify}/bin/notify-send 'Locking soon'" \
                -detectsleep \
                -killtime 30 \
                -killer "systemctl suspend"
    '';
      executable = true;
    };
  };
}

  # ${pkgs.xautolock}/bin/xautolock -time 10 \
  # -locker physlock \
