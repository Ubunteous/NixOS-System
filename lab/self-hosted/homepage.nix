{ config, lib, user, ... }:

with lib;
let
  cfg = config.lab.homepage;
  labcfg = config.lab;
in {
  options.lab.homepage = {
    enable = mkEnableOption "Enables support for Homepage";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    ####################
    #     HOMEPAGE     #
    ####################

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
          Monitoring = { # group Name in services/bookmarks.yaml
            style = "column";
            rows = "3";
            # initiallyCollapsed = "true";
            # tab = "First"; # not giving a tab puts column on every tab
          };

          Server = {
            style = "column";
            rows = "3";
            # tab = "Second";
          };

          Multimedia = {
            style = "column";
            rows = "2";
            columns = "3";
          };

          Utilities = {
            style = "column";
            rows = "4";
          };

          arr = {
            style = "row";
            rows = "2";
            columns = "3";
          };
        };
      };

      services = [

        {
          "Multimedia " = [
            {
              "Caddy share" = {
                icon = "caddy.png";
                href = "http://localhost:2016/";
              };
            }
            {
              "qBittorrent Web" = {
                icon = "qbittorrent.png";
                href = "http://localhost:8080/";
              };
            }
            {
              "Navidrome" = {
                icon = "navidrome.png";
                href = "http://localhost:4533/";
              };
            }
            {
              "Shiori" = {
                icon = "shiori.png";
                href = "http://localhost:2525/";
              };
            }
            {
              "Jellyfin" = {
                icon = "jellyfin.png";
                href = "http://localhost:8096/";
              };
            }
            {
              "Jellyseer" = {
                icon = "jellyfin.png";
                href = "http://localhost:5055/";
              };
            }
            {
              "Plex" = {
                icon = "plex.png";
                href = "http://localhost:32400/web/";
              };
            }

            {
              "Tautulli" = {
                icon = "tautulli.png";
                href = "http://localhost:8181/";
              };
            }
            # {
            #   "kavita" = {
            #     icon = "kavita.png";
            #     href = "http://localhost:5000/";
            #   };
            # }
          ];
        }

        {
          "Monitoring" = [
            {
              "Grafana" = {
                icon = "grafana.png";
                href = "http://localhost:3002/"; # default: 3000
              };
            }
            {
              "Prometheus" = {
                icon = "prometheus.png";
                href = "http://localhost:9090/";
              };
            }
            {
              "Loki" = {
                icon = "loki.png";
                href = "http://localhost:8082/"; # no link yet
                # ping: sonarr.host # for http://sonarr.host/
                # siteMonitor = "http://localhost:3002/"; # verify site exists
              };
            }
          ];
        }

        {
          "Server" = [
            {
              "Caddy" = {
                icon = "caddy.png";
                href = "http://localhost:2019/"; # admin port
              };
            }
            {
              "Traefik" = {
                icon = "traefik.png";
                href = "http://localhost/";
              };
            }
            {
              "Nginx" = {
                icon = "nginx.png";
                href = "http://localhost:80/"; # http port
              };
            }
          ];
        }

        {
          "Utilities" = [
            {
              "Syncthing" = {
                icon = "syncthing.png";
                href = "http://localhost:8384/";

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
                href = "http://localhost:8000/";
              };
            }
            {
              "Adguard" = {
                icon = "adguard-home.png";
                href = "http://localhost:3090/";
              };
            }
            {
              "Wireguard" = {
                icon = "wireguard.png";
                href = "http://localhost:8082/"; # change port later
              };
            }
          ];
        }

        {
          "arr" = [
            {
              "Radarr (movies)" = {
                icon = "radarr.png";
                href = "http://localhost:7878/";
              };
            }
            {
              "Bazaar (sub)" = {
                icon = "https://www.bazarr.media/assets/img/logo.png";
                href = "http://localhost:6767/"; # default: 9090
              };
            }
            {
              "Sonarr (tv)" = {
                icon = "sonarr.png";
                href = "http://localhost:8989/";
              };
            }
            {
              "Readarr (books)" = {
                icon = "readarr.png";
                href = "http://localhost:8787/";
              };
            }
            {
              "Lidarr (music)" = {
                icon = "lidarr.png";
                href = "http://localhost:8686/";
              };
            }
            {
              "Prowlarr (indexer)" = {
                icon = "prowlarr.png";
                href = "http://localhost:9696/";
              };
            }
          ];

        }
      ];

      bookmarks = [
        {
          Developer = [
            {
              JS-App = [{
                abbr = "JA";
                href = "http://localhost:3000/";
              }];
            }
            {
              Django-App = [{
                abbr = "DA";
                href = "http://localhost:8000/";
              }];
            }
            {
              Github = [{
                abbr = "GH"; # abbr expected to be 2 letters long
                # icon = "github-light.png";
                href = "https://github.com/";
              }];
            }
          ];
        }

        {
          Javascript = [
            {
              React-Learn = [{
                abbr = "RL";
                href = "https://react.dev/learn";
              }];
            }
            {
              React-API = [{
                abbr = "RA";
                href = "https://react.dev/reference/react";
              }];
            }
            {
              Express = [{
                abbr = "EX";
                href = "http://expressjs.com/";
              }];
            }
          ];
        }

        {
          Documentation = [
            {
              Homepage = [{
                abbr = "HP";
                href = "https://gethomepage.dev/latest/";
              }];
            }
            {
              Mozilla = [{
                abbr = "MZ";
                href = "https://developer.mozilla.org/en-US/docs/Web";
              }];
            }
          ];
        }
      ];

      # customJS = '' '';
      # customCSS = '' '';

      # kubernetes = {};
      # docker = {};

      # environmentFile = "";

      # http://localhost:8082/
      # listenPort = 8082; # default is 8082

      # Open listen port in the firewall for Homepage
      # note these: 22000 (transfers) and 21027 (discovery)
      openFirewall = true;
    };
  };
}
