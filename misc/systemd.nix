{ config, pkgs, ... }:

{
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
