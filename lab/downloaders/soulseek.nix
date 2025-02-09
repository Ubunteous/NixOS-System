{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.lab.slskd;
  labcfg = config.lab;
in {
  options.lab.slskd = { enable = mkEnableOption "Enables support for slskd"; };

  config = mkIf (labcfg.enable && cfg.enable) {
    #####################
    #       SLSKD       #
    #####################

    services.slskd = {
      enable = true;

      openFirewall = true;
      domain = "localhost";

      # replace by impure file or encrypted
      environmentFile = pkgs.writeText "slskd.env" ''
        SLSKD_SLSK_USERNAME=slskd
        SLSKD_SLSK_PASSWORD=slskd
        SLSKD_USERNAME=slskd
        SLSKD_PASSWORD=slskd
      '';

      ################
      #   SETTINGS   #
      ################

      settings = {
        # false by default. enable content edition from webui
        # remote_file_management = true;

        # directories = {
        #   # incomplete = "/var/lib/slskd/incomplete";
        #   downloads = "/var/data/media/musics/"; # "/var/lib/slskd/downloads";
        # };

        # web = {
        #   # url_base = "/";
        #   # port = 5030;
        #   # https.disabled = true;
        # };

        # soulseek = {
        #   # listen_port = 50300;
        #   # description = "A slskd user. https://github.com/slskd/slskd";
        # };

        shares = {
          directories = [ "/var/data/media/musics" ];
          # filters = [ "\.ini$" "Thumbs.db$" "\.DS_Store$" ];
        };

        # retention = {
        #   transfers = {
        #     upload = {
        #       # succeeded = "(indefinite)";
        #       # errored = "(indefinite)";
        #       # cancelled = "(indefinite)";
        #     };

        #     download = {
        #       # succeeded = "(indefinite)";
        #       # errored = "(indefinite)";
        #       # cancelled = "(indefinite)";
        #     };
        #   };

        # files = {
        #     # incomplete = "(indefinite)";
        #     # complete = "(indefinite)";
        #   };
        # };

        # global = {
        #   upload = {
        #     # speed_limit
        #     # slots
        #   };

        #   download = {
        #     # speed_limit
        #     # slots
        #   };
        # };

        # flags.force_share_scan = true; # scan on startup # example
        # filters.search.request = [ "^.{1,2}$" ]; # example
        # rooms = [""]; # chat rooms to join on startup
      };

      ###############
      #   DEFAULT   #
      ###############

      # user = "slskd";
      # group = "slskd";
      # package = pkgs.slskd;
    };
  };
}
