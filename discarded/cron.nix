{pkgs, ...}:

{
  ############
  #   CRON   #
  ############

  services.cron = {
    enable = true;
    systemCronJobs = [
      "*/1 * * * * ubunteous /home/ubunteous/Desktop/test.sh"

      # "*/1 * * * * ubunteous ${pkgs.dunst}/bin/dunstify 'Hey'"      
    ];
  };


  systemd.user.services."minute-cron" = {
    serviceConfig.Type = "oneshot";
    script = ''
           DUNSTIFY=${pkgs.dunst}/bin/dunstify
           "$DUNSTIFY" "hello from your script"
           '';
  };

  systemd.user.timers."minute-cron-timer" = {
    wantedBy = [ "timers.target" ];
    partOf = [ "minute-cron.service" ];
    timerConfig.OnCalendar = "minutely";
    timerConfig.Unit = "minute-cron.service";
  };
}
