{ config, lib, ... }:

with lib;
let
  cfg = config.lab.kavita;
  labcfg = config.lab;
  in {

    options.lab.kavita = {
    enable = mkEnableOption "Enables support for kavita";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.kavita = {
      enable = true;

      # user = "kavita";
      # dataDir = "/var/lib/kavita";
      # package = pkgs.kavita;

      # generate with: head -c 64 /dev/urandom | base64 --wrap=0
      tokenKeyFile = ../../files/kavita-token;

      # settings = {
      #   # see appsettings.json
      #   # Port = 5000;
      #   # IpAddresses = "0.0.0.0,::";
      # };

    };
  };
}
