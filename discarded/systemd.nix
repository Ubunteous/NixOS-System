{ config, pkgs, ... }:

{
  #####################
  # LIBNOTIFY ATTEMPT #
  #####################

  systemd = {
    timers."notify" = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnStartupSec = "1s";
        AccuracySec = "1us";
        Unit = "notify.service";
      };
    };
    services."notify" = {
      script = ''
        {pkgs.libnotify}/bin/notify-send --urgency=critical "Systemd Service has failed"
      '';
      environment = { Display = ":0.0"; };
      serviceConfig = {
        # Type = "oneshot";
        User = "ubunteous";
      };
    };
  };

  # systemd.timers."20-break" = {
  #   wantedBy = [ "timers.target" ];
  #   timerConfig = {
  #     # OnBootSec = "21m";
  #     # OnUnitActiveSec = "21m";
  #     OnBootSec = "10s";
  #     OnUnitActiveSec = "10s";

  #     Unit = "20-break.service";
  #   };
  # };

  # systemd.services."20-break" = {
  #   script =
  #     "${pkgs.dunst}/bin/dunstify -u critical -t 30000 'It is time for a break';";
  #   serviceConfig = {
  #     Type = "oneshot";
  #     User = "root";
  #   };
  # };

  #############
  #  SYSTEMD  #
  #############

  #systemd.user.services.sticky = {
  #systemd.services.sticky = {
  #  #serviceConfig.Type = "oneshot";
  #  description = "Make keys sticky";
  #  script = ''
  #    echo "start sticky"
  #    nemo
  #    xkbset exp -bell -sticky -twokey -latchlock -accessx -feedback -stickybeep -led 9999
  #    xkbset bell sticky -twokey -latchlock feedback led stickybeep
  #  '';
  #  wantedBy = [ "multi-user.target" ];
  #  partOf = [ "graphical-session.target" ];
  #};

  #systemd.services.echo = {
  #    description = "Echo to the journal";
  #    wantedBy = [ "multi-user.target" ];
  #    serviceConfig.Type = "oneshot";
  #    script = ''
  #      echo "A" >> /home/ubunteous/Desktop/test.txt

  #    xkbset exp -bell -sticky -twokey -latchlock -accessx -feedback -stickybeep -led 9999
  #    xkbset bell sticky -twokey -latchlock feedback led stickybeep

  #    '';
  #  };
}
