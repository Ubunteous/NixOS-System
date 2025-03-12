{ config, lib, ... }:

with lib;
let
  cfg = config.lab.git;
  labcfg = config.lab;
in {
  config = mkIf (labcfg.enable && cfg.enable && cfg.webUI == "gitweb") {
    services.nginx = {
      enable = true;

      gitweb = {
        enable = true;
        # location = "/gitweb"; # http://localhost/gitweb/
      };
    };

    services.gitweb = {
      projectroot = cfg.repoDir;

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
