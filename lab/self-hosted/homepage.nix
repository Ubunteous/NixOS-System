{ config, lib, ... }:

with lib;
let
  cfg = config.lab.homepage;
  labcfg = config.lab;
in {
  options.lab.homepage = {
    enable = mkEnableOption "Enables support for Homepage";

    address = mkOption {
      type = types.enum [ "server" "localhost" ];
      default = "localhost";
      description = lib.mdDoc ''
        Service address. Either server (dns setting) or localhost.
      '';
    };
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    ########################
    #       HOMEPAGE       #
    ########################

    services.homepage-dashboard = {
      enable = true;

      widgets = [
        {
          datetime = {
            # text_size = "xl"; # 4xl, 3xl, 2xl, xl, md, sm, xs
            locale = "en";
            format = {
              dateStyle = "long";
              timeStyle = "short";
            };
          };
        }
        {
          resources = { # glances monitors ext machine
            cpu = true;
            disk = "/";
            memory = true;
          };
        }
        # {
        #   search = {
        #     provider = "duckduckgo";
        #     target = "_blank";
        #   };
        # }
      ];

      settings = {
        title = "Dashboard"; # name appears in tab rect
        # startUrl =  "https://homepage.url";
        # language = "en";

        background = {
          image =
            "https://images.unsplash.com/photo-1502790671504-542ad42d5189?auto=format&fit=crop&w=2560&q=80";
          # blur = "sm"; # sm, md, xl
          # saturate = "50"; # 0, 50, 100
          # brightness = "50"; # 0, 50, 75
          # opacity = "50"; # 0-100
        };

        theme = "dark";
        # color = "teal"; # does it even work?

        cardBlur = "sm";
        headerStyle = "clean";
        useEqualHeights = "true";

        layout = {
          Arr = {
            style = "column";
            rows = "3";
          };
          Backup = {
            style = "column";
            rows = "3";
          };
          Streaming = {
            style = "column";
            rows = "3";
          };
          Torrent = {
            style = "column";
            rows = "3";
          };

          arr = {
            style = "column";
            rows = "3";
          };
          git = {
            style = "column";
            rows = "3";
          };
          torrent = {
            style = "column";
            columns = "2";
            rows = "3";
          };
          monitoring = { # group Name in services/bookmarks.yaml
            style = "column";
            columns = "3";
            # initiallyCollapsed = "true";
            # tab = "First"; # not giving a tab puts column on every tab
          };
          fileshare = {
            style = "column";
            columns = "3";
            # tab = "Second";
          };

          security = {
            style = "column";
            rows = "3";
          };
          streaming = {
            style = "column";
            rows = "3";
          };
        };
      };

      services = [
        {
          "Arr" = [
            {
              "Radarr (films)" = {
                icon = "radarr.png";
                href = "http://${cfg.address}:7878/";
              };
            }
            {
              "Bazaar (subs)" = {
                icon = "bazarr.png";
                href = "http://${cfg.address}:6767/"; # default: 9090
              };
            }
            {
              "Sonarr (series)" = {
                icon = "sonarr.png";
                href = "http://${cfg.address}:8989/";
              };
            }
          ];
        }

        {
          "Backup" = [
            {
              "Syncthing" = {
                icon = "syncthing.png";
                href = "http://${cfg.address}:8384/";

                # # requires syncthing relay
                # widget = {
                #   type = "strelaysrv";
                #   url = "http://syncthing.host.or.ip:22070";
                # };
              };
            }
            {
              "Restic" = {
                # icon = "restic.png"; # unavailable
                icon =
                  "https://forum.restic.net/uploads/default/original/1X/3773c7993ff25bf4c15aa18cdd336f94bccd96f5.png";
                href = "http://${cfg.address}:8000/";
              };
            }
            {
              "Borg" = {
                icon = "borg.png";
                href = "http://${cfg.address}:8082/";
              };
            }
            # {
            #   "Kopia" = {
            #     icon = "kopia.png";
            #     href = "http://${cfg.address}:8082/";
            #   };
            # }
          ];
        }

        {
          "Streaming" = [
            {
              "Plex" = {
                icon = "plex.png";
                href = "http://${cfg.address}:32400/web/";
              };
            }
            {
              "Navidrome" = {
                icon = "navidrome.png";
                href = "http://${cfg.address}:4533/";
              };
            }
            {
              "Komga" = {
                icon = "komga.png";
                href = "http://${cfg.address}:8069/";
              };
            }
            # {
            #   "Kavita" = {
            #     icon = "kavita.png";
            #     href = "http://${cfg.address}:5000/";
            #   };
            # }
          ];
        }

        {
          "Torrent" = [
            {
              "qBittorrent" = {
                icon = "qbittorrent.png";
                href = "http://${cfg.address}:8080/";
              };
            }
            {
              "sabnzbd" = {
                icon = "sabnzbd.png";
                href = "http://${cfg.address}:8080";
              };
            }
            {
              "soulseek" = {
                icon = "soulseek.png";
                href = "http://${cfg.address}:5030";
              };
            }
          ];
        }

        {
          "torrent" = [
            {
              "Deluge" = {
                icon = "deluge.png";
                href = "http://${cfg.address}:8112/";
              };
            }
            {
              "transmission" = {
                icon = "transmission.png";
                href = "http://${cfg.address}:9091/";
              };
            }
            {
              "rutorrent/rtorrent" = {
                icon = "rutorrent.png";
                href = "http://${cfg.address}:50000/";
              };
            }
            {
              "nzbget" = {
                icon = "nzbget.png";
                href = "http://${cfg.address}:6789/";
              };
            }
          ];
        }

        {
          "fileshare" = [
            {
              "Caddy share" = {
                icon = "caddy.png";
                href = "http://${cfg.address}:2016/";
                # href = "http://${cfg.address}:2019/"; # admin port
              };
            }
            {
              "Filebrowser" = {
                icon = "filebrowser.png";
                href = "http://${cfg.address}:8888/";
              };
            }
            {
              "Traefik" = {
                icon = "traefik.png";
                href = "http://${cfg.address}:8082";
              };
            }
            # {
            #   "Nginx" = {
            #     icon = "nginx.png";
            #     href = "http://${cfg.address}:80/"; # http port
            #   };
            # }
          ];
        }

        {
          "git" = [
            {
              "Gitea" = {
                icon = "gitea.png";
                href = "http://${cfg.address}:3000";
              };
            }
            {
              "Gitweb" = {
                icon = "git.png";
                href = "http://${cfg.address}/gitweb";
              };
            }
            {
              "cgit" = {
                icon = "git.png";
                href = "http://${cfg.address}/cgit";
              };
            }
          ];
        }

        {
          "security" = [
            {
              "Adguard" = {
                icon = "adguard-home.png";
                href = "http://${cfg.address}:3000/";
              };
            }
            {
              "Wireguard" = {
                icon = "wireguard.png";
                href = "http://${cfg.address}:8082/"; # change port later
              };
            }
            {
              "flaresolverr" = {
                icon = "flaresolverr.png";
                href = "http://${cfg.address}:8191/";
              };
            }
          ];
        }

        {
          "streaming" = [
            {
              "Tautulli" = {
                icon = "tautulli.png";
                href = "http://${cfg.address}:8181/";
              };
            }
            {
              "Jellyfin" = {
                icon = "jellyfin.png";
                href = "http://${cfg.address}:8096/";
              };
            }
            {
              "Jellyseer" = {
                icon = "jellyfin.png";
                href = "http://${cfg.address}:5055/";
              };
            }
          ];
        }

        {
          "monitoring" = [
            {
              "Grafana" = {
                icon = "grafana.png";
                href = "http://${cfg.address}:3002/"; # default: 3000
              };
            }
            {
              "Prometheus" = {
                icon = "prometheus.png";
                href = "http://${cfg.address}:9090/";
              };
            }
            {
              "Loki" = {
                icon = "loki.png";
                href = "http://${cfg.address}:8082/"; # no link yet
                # ping: sonarr.host # for http://sonarr.host/
                # siteMonitor = "http://${cfg.address}:3002/"; # verify site exists
              };
            }
          ];
        }

        {
          "arr" = [
            {
              "Lidarr (music)" = {
                icon = "lidarr.png";
                href = "http://${cfg.address}:8686/";
              };
            }
            {
              "Readarr (books)" = {
                icon = "readarr.png";
                href = "http://${cfg.address}:8787/";
              };
            }
            {
              "Prowlarr (index)" = {
                icon = "prowlarr.png";
                href = "http://${cfg.address}:9696/";
              };
            }
          ];
        }
      ];

      # bookmarks = [
      #   {
      #     Developer = [
      #       {
      #         JS-App = [{
      #           abbr = "JA";
      #           href = "http://${cfg.address}:3000/";
      #         }];
      #       }
      #       {
      #         Django-App = [{
      #           abbr = "DA";
      #           href = "http://${cfg.address}:8000/";
      #         }];
      #       }
      #       {
      #         Github = [{
      #           abbr = "GH"; # abbr expected to be 2 letters long
      #           # icon = "github-light.png";
      #           href = "https://github.com/";
      #         }];
      #       }
      #     ];
      #   }

      #   {
      #     Javascript = [
      #       {
      #         React-Learn = [{
      #           abbr = "RL";
      #           href = "https://react.dev/learn";
      #         }];
      #       }
      #       {
      #         React-API = [{
      #           abbr = "RA";
      #           href = "https://react.dev/reference/react";
      #         }];
      #       }
      #       {
      #         Express = [{
      #           abbr = "EX";
      #           href = "http://expressjs.com/";
      #         }];
      #       }
      #     ];
      #   }

      #   {
      #     Documentation = [
      #       {
      #         Homepage = [{
      #           abbr = "HP";
      #           href = "https://gethomepage.dev/latest/";
      #         }];
      #       }
      #       {
      #         Mozilla = [{
      #           abbr = "MZ";
      #           href = "https://developer.mozilla.org/en-US/docs/Web";
      #         }];
      #       }
      #     ];
      #   }
      # ];

      # customJS = '' '';
      # customCSS = '' '';

      # kubernetes = {};
      # docker = {};

      # environmentFile = "";

      # http://${cfg.address}:8082/
      # listenPort = 8082; # default is 8082

      # Open listen port in the firewall for Homepage
      # note these: 22000 (transfers) and 21027 (discovery)
      openFirewall = true;
    };
  };
}
