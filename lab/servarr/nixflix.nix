{ config, lib, ... }:

with lib;
let
  cfg = config.lab.nixflix;
  labcfg = config.lab;
in {

  options.lab.nixflix = {
    enable = mkEnableOption "Enables support for nixflix";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    # Hide passwords if forwarding ports to router

    # ports:
    # torrent (qbit): 8282

    nixflix = {
      enable = true;

      # these paths default to /data/.*
      mediaDir = "/srv/data/media";
      stateDir = "/srv/data/.state";
      downloadsDir = "/srv/data/downloads";

      mediaUsers = [ "media" ];

      theme = {
        enable = true;
        name = "dark"; # "overseerr"; # defaults to plex
      };

      nginx = {
        enable = true;

        # Disable this is you have your own DNS configuration
        addHostsEntries = true;
      };

      # can be in conflict with postgresql
      postgres.enable = true;

      # # too early. not documented yet and broken
      # torrentClients.qbittorrent = {
      #   enable = true;

      #   password = "qbittorrent";
      #   serverConfig.Preferences.WebUI.Username = "qbittorrent";
      # };

      radarr = {
        enable = true;
        # openFirewall = true;

        config = {
          apiKey = "default-radarr-api-key";
          hostConfig.password = "radarr";
        };
      };

      prowlarr = {
        enable = true;
        # openFirewall = true;

        config = {
          apiKey = "default-prowlarr-api-key";
          hostConfig.password = "prowlarr";

          indexers = [{ name = "Nyaa.si"; }];
        };
      };

      # sonarr = {
      #   enable = true;
      #   # openFirewall = true;

      #   config = {
      #     apiKey = "default-radarr-api-key";
      #     hostConfig.password = "sonarr";
      #   };
      # };

      # sonarr-anime = {
      #   enable = true;
      #   openFirewall = true;

      #   config = {
      #     apiKey = "default-radarr-api-key";
      #     hostConfig.password = "sonarr";
      # 	};
      # };

      # sabnzbd = {
      #   enable = true;
      #   openFirewall = true;
      #   settings = {
      #     # check servers config in doc when needed
      #     misc.api_key = {
      #       _secret = config.sops.secrets."sabnzbd/api_key".path;
      #     };
      #   };
      # };

    };
  };
}
