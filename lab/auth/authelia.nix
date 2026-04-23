{ config, lib, ... }:

with lib;
let
  cfg = config.lab.authelia;
  labcfg = config.lab;
in {

  options.lab.authelia = {
    enable = mkEnableOption "Enables support for authelia";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.authelia.instances.myinstance = {
      enable = true;
      name = "myinstance";

      # user = "authelia-<name>";
      # group = "authelia-<name>";

      # settingsFiles = [
      #   "/etc/authelia/config.yml"
      #   "/etc/authelia/access-control.yml"
      #   "/etc/authelia/config/"
      # ];

      # environmentVariables

      settings = {
        theme = "dark";

        # telemetry = {
        #   metrics.enabled = false; # default
        #   telemetry.metrics.address = "tcp://127.0.0.1:9959";
        # };

        # server.address = "tcp://:9091/"; # default

        log = {
          # level = "debug"; # default
          # keep_stdout = false; # default
          format = "text";
          file_path = "/var/log/authelia/authelia.log";
          default_2fa_method = "totp"; # "", "totp", "webauthn" or "mobile_push"
        };
      };

      secrets = {
        manual = true;

        #       # mandatory if manual is false
        # 	storageEncryptionKeyFile = "/path/to/key";
        # 	jwtSecretFile = "/path/to/file";

        # 	sessionSecretFile = "/path/to/secret";
        # 	oidcIssuerPrivateKeyFile = "/path/to/file";
        # 	oidcHmacSecretFile = "/path/to/file";
      };

    };
  };
}
