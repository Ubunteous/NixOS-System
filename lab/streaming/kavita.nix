{ config, lib, ... }:

with lib;
let
  cfg = config.lab.kavita;
  labcfg = config.lab;
in
  {
	options.lab.kavita = {
      enable = mkEnableOption "Enables support for kavita";
	};

	options.services.kavita.openFirewall = mkOption {
    type = types.bool;
    default = false;
    description = lib.mdDoc ''
      Open services.kavita.settings.Port to other devices.
    '';
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    # port is already defined in kavita configuration
    networking.firewall = mkIf cfg.openFirewall { allowedTCPPorts = [ cfg.port ]; };

    services.kavita = {
      enable = true;

      openFirewall = true;

      # user = "kavita";
      # dataDir = "/var/lib/kavita";
      # package = pkgs.kavita;

      # generate with: head -c 64 /dev/urandom | base64 --wrap=0
      tokenKeyFile = ../../files/kavita-token;

      settings = {
        # see appsettings.json
        Port = cfg.port;
        IpAddresses = "0.0.0.0,::";
      };

    };
  };
}
