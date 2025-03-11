{ config, lib, ... }:

with lib;
let
  cfg = config.lab.gitweb;
  labcfg = config.lab;
in {

  options.lab.gitweb = {
    enable = mkEnableOption "Enables support for gitweb";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.nginx = {
      enable = true;

      gitweb = {
        enable = true;
        # location = "/gitweb"; # http://localhost/gitweb/
      };
    };

    services.gitweb = {
      projectroot = "/var/www/git";

      # gitwebTheme = false;
      # extraConfig = ''
      #   $feature{'highlight'}{'default'} = [1];
      #   $feature{'ctags'}{'default'} = [1];
      #   $feature{'avatar'}{'default'} = ['gravatar'];
      # '';

      # projects_list = "/home/git/projects.list";
    };
  };
}
