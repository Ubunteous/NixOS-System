{ config, lib, pkgs, ... }:

with lib;

let cfg = config.services.filebrowser;
in {
  options.services.filebrowser = {
    enable = mkEnableOption (lib.mdDoc "filebrowser headless");

    dataDir = mkOption {
      type = types.path;
      default = "/var/lib/filebrowser";
      description = lib.mdDoc ''
        The directory where filebrowser stores its data files.
      '';
    };

    databasePath = mkOption {
      type = types.path;
      default = "${cfg.dataDir}/filebrowser.db";
      description =
        lib.mdDoc "The directory where filebrowser stores its database.";
    };

    noauth = mkOption {
      type = types.bool;
      default = false;
      description = lib.mdDoc "Leave to default to skip login.";
    };

    user = mkOption {
      type = types.str;
      default = "filebrowser";
      description = lib.mdDoc ''
        User account under which filebrowser runs.
      '';
    };

    group = mkOption {
      type = types.str;
      default = "filebrowser";
      description = lib.mdDoc ''
        Group under which filebrowser runs.
      '';
    };

    port = mkOption {
      type = types.port;
      default = 8080;
      description = lib.mdDoc ''
        filebrowser port.
      '';
    };

    rootDir = mkOption {
      type = types.str;
      default = "/var/lib/filebrowser";
      description = "root directory shared";
    };

    address = mkOption {
      type = types.str;
      default = "127.0.0.1";
      description = "address to listen on";
    };

    openFirewall = mkOption {
      type = types.bool;
      default = false;
      description = lib.mdDoc ''
        Open services.filebrowser.port to the outside network.
      '';
    };

    package = mkOption {
      type = types.package;
      default = pkgs.filebrowser;
      defaultText = literalExpression "pkgs.filebrowser";
      description = lib.mdDoc ''
        The filebrowser package to use.
      '';
    };
  };

  config = mkIf cfg.enable {
    networking.firewall =
      mkIf cfg.openFirewall { allowedTCPPorts = [ cfg.port ]; };

    systemd.services.filebrowser = {
      description = "filebrowser service";
      documentation = [ "man:filebrowser(1)" ];
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "simple";
        User = cfg.user;
        Group = cfg.group;

        ExecStartPre = let
          preStartScript = pkgs.writeScript "filebrowser-run-prestart" ''
            #!${pkgs.bash}/bin/bash

            # Create data directory if it doesn't exist
            if ! test -d "FB_DATABASE"; then
              echo "Creating initial filebrowser data directory in: ${cfg.dataDir}"
              install -d -m 0755 -o "${cfg.user}" -g "${cfg.group}" ${cfg.dataDir}			  
            fi
          '';
        in "!${preStartScript}";

        ExecStart = "${cfg.package}/bin/filebrowser";
      };

      environment = {
        FB_DATABASE = cfg.databasePath;
        FB_PORT = toString cfg.port;
        FB_ADDRESS = cfg.address;
        FB_ROOT = cfg.rootDir;

        # works if db not created yet
        FB_NOAUTH = if cfg.noauth then "noauth" else "";

        # FB_BRANDING.DISABLEEXTERNAL = "true"; # no idea what it does

        # others:
        # --config
        # --baseurl
        # --username
        # --cache-dir (filecache)
      };
    };

    users.users = mkIf (cfg.user == "filebrowser") {
      filebrowser = {
        group = cfg.group;
        uid = 888;
      };
    };

    users.groups =
      mkIf (cfg.group == "filebrowser") { filebrowser = { gid = 888; }; };
  };
}
