{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.sabnzbd-fixed;
  inherit (pkgs) sabnzbd;
in {
  options = {
    services.sabnzbd-fixed = {
      enable = mkEnableOption "the sabnzbd server";

      package = mkPackageOption pkgs "sabnzbd" { };

      configFile = mkOption {
        type = types.path;
        default = "/var/lib/sabnzbd/sabnzbd.ini";
        description = "Path to config file.";
      };

      user = mkOption {
        default = "sabnzbd";
        type = types.str;
        description = "User to run the service as";
      };

      group = mkOption {
        type = types.str;
        default = "sabnzbd";
        description = "Group to run the service as";
      };

      port = mkOption {
        type = types.port;
        default = 8081;
        description = lib.mdDoc ''
          sabnzbd web UI port.
        '';
      };

      openFirewall = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Open ports in the firewall for the sabnzbd web interface
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    users.users = mkIf (cfg.user == "sabnzbd") {
      sabnzbd-fixed = {
        uid = config.ids.uids.sabnzbd;
        group = cfg.group;
        description = "sabnzbd user";
      };
    };

    users.groups =
      mkIf (cfg.group == "sabnzbd") { sabnzbd.gid = config.ids.gids.sabnzbd; };

    systemd.services.sabnzbd = {
      description = "sabnzbd server";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      serviceConfig = {
        Type = "forking";
        GuessMainPID = "no";
        User = cfg.user;
        Group = cfg.group;
        StateDirectory = "sabnzbd";
        ExecStart =
          "${lib.getBin cfg.package}/bin/sabnzbd -d -f ${cfg.configFile}";
      };
    };

    networking.firewall =
      mkIf cfg.openFirewall { allowedTCPPorts = [ cfg.port ]; };
  };
}
