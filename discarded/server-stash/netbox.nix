{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.lab.netbox;
  labcfg = config.lab;
in {

  options.lab.netbox = {
    enable = mkEnableOption "Enables support for netbox";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.netbox = {
      enable = true;
      package = pkgs.netbox; # default is broken and uses v3.3
      secretKeyFile = "/path"; # needed

      # dataDir = "/var/lib/netbox";
      # settings.ALLOWED_HOSTS = [ "*" ];
      # enableLdap = false;
      # settings = {};
      # port = 8001;
      # plugins = python3Packages: with python3Packages; [ ];
      # listenAddress = "[::1]";
      # ldapConfigPath = ""; # '' python config '';
      # keycloakClientSecret = null;
      # extraConfig = "";
    };
  };
}
