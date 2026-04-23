{ config, lib, ... }:

with lib;
let
  cfg = config.lab.keycloak;
  labcfg = config.lab;
in {

  options.lab.keycloak = {
    enable = mkEnableOption "Enables support for keycloak";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.keycloak = {
      enable = true;

      # packages = pkgs.keycloak;
      # realmFiles = []; # paths to json files	  
      # initialAdminPassword = null;
      # themes = {};
      # plugins = [];  # paths
      # sslCertificateKey = null;
      # sslCertificate = null;

      settings = {
        # https-port = 443;
        # http-port = 80;
        # http-host = "::";
        # http-relative-path = "/";
        # hostname-backchannel-dynamic = false;
        # hostname = null;
      };

      database = {
        # username = "keycloak";
        # useSSL = config.services.keycloak.database.host != "localhost";
        # port; # default port of selected database
        # passwordFile;
        # name = "keycloak";
        # host = "localhost";
        # createLocally = true;
        # type = "postgresql";
        # caCert = null;
      };
    };
  };
}
