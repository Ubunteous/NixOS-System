{ config, lib, ... }:

with lib;
let
  cfg = config.lab.cgit;
  labcfg = config.lab;
in {

  options.lab.cgit = { enable = mkEnableOption "Enables support for cgit"; };

  config = mkIf (labcfg.enable && cfg.enable) {
    services.nginx.enable = true;

    # services.lighttpd.cgit = {
    #   enable = true;
    #   subdir = "cgit";
    #   configText = ''
    # 	scan-path=/var/www/git
    #   '';
    # };

    services.cgit.localhost = {
      enable = true;

      scanPath = "/var/www/git/";

      # repos = {
      #   mischief = {
      #     desc = "What are you plotting?";
      #     path = "/var/www/git/Mischief.git";
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
