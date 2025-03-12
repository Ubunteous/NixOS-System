{ config, lib, ... }:

with lib;
let
  cfg = config.lab.git;
  labcfg = config.lab;
in {

  # options.lab.cgit = { enable = mkEnableOption "Enables support for cgit"; };

  config = mkIf (labcfg.enable && cfg.enable && cfg.webUI == "cgit") {
    services.nginx.enable = true;

    # services.lighttpd.cgit = {
    #   enable = true;
    #   subdir = "cgit";
    #   configText = ''
    # 	scan-path=cfg.repoDir;
    #   '';
    # };

    services.cgit.localhost = {
      enable = true;

      scanPath = cfg.repoDir;

      # repos = {
      #   mischief = {
      #     desc = "What are you plotting?";
      #     path = "${cfg.repoDir}/Mischief.git";
      #   };
      # };

      # extraConfig = "";

      # user = "cgit";
      # group = "cgit";
      # package = pkgs.cgit;

      # settings = {
      #   enable-follow-links = true;
      #   source-filter = "${pkgs.cgit}/lib/cgit/filters/syntax-highlighting.py";
      # };

      nginx.location = "/cgit"; # "/git/";
      nginx.virtualHost = "localhost";
    };
  };
}
