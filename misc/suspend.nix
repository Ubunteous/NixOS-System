{ pkgs, ... }:

{

  # services.physlock.enable = true;
  # services.physlock.allowAnyUser = true;
  # services.xserver.xautolock.enable = true;
  # services.xserver.xautolock.time = 1;
  # services.xserver.xautolock.locker = "/run/wrappers/bin/physlock";

  # !!!!! https://man.archlinux.org/man/logind.conf.5.en
  # IdleAction = "suspend"
  # IdleActionSec = 
  services.logind.extraConfig = ''
    IdleAction=suspend
    IdleActionSec=1min
  '';

  # systemd.sleep.extraConfig = "SleepDelaySec=1m"
  # xautolock
  # services.xserver.xautolock = {
  #   enable = true;

  #   # locker = "${pkgs.xlockmore}/bin/xlock"; # "${pkgs.cinnamon.cinnamon-screensaver}/bin";
  #   nowlocker = "${pkgs.xlockmore}/bin/xlock";
  #   time = 1;

  #   enableNotifier = true;
  #   notifier = "${pkgs.libnotify}/bin/notify-send 'Locking soon'";
  #   # notifier = "${pkgs.dunst}/bin/dunstify 'Locking soon'";
  #   notify = 55;

  # services.xserver.xautolock.killtime = 10;
  # killer = "/run/current-system/systemd/bin/systemctl suspend";
  # };

  #################
  #   XAUTOLOCK   #
  #################

  # xautolock = "${pkgs.lightlocker}/bin/light-locker";
  #   xautolock = {
  #     enable = true;
  #     time = 1;
  #     # 3 options: enable notify/ier = # require another tool
  
  #     locker = "${pkgs.xlockmore}/bin/xlock";
  #     nowlocker = "${pkgs.xlockmore}/bin/xlock";
  #   };  

  # programs.xsslock = {
  #   enable = true;
  #   lockerCommand = 
  # };

  # xautolock -time 1 -locker "/run/wrappers/bin/physlock" -notify 50 -notifier "notify-send 'Screen will lock in 50s'" -detectsleep

  # services.xserver.xautolock.enable = true;
  # services.xserver.xautolock.time = 1;
  # services.xserver.xautolock.locker = "/run/wrappers/bin/physlock";
  # services.xserver.xautolock.nowlocker = "/run/wrappers/bin/physlock && echo 'Suspension'";

}
  


  
