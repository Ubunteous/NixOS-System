{ config, lib, user, ... }:

with lib;
let
  cfg = config.lab.homepage;
  labcfg = config.lab;
  address = "server"; # server or localhost
in {
  options.lab.homepage = {
    enable = mkEnableOption "Enables support for Homepage";
  };

  config = mkIf (labcfg.enable && cfg.enable) {
    ####################
    #       HOMEPAGE       #
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
          Backup = {
            style = "column";
            rows = "3";
          };

          Proxy = {
            style = "column";
            columns = "3";
            # tab = "Second";
          };

          Monitoring = { # group Name in services/bookmarks.yaml
            style = "column";
            columns = "3";
            # initiallyCollapsed = "true";
            # tab = "First"; # not giving a tab puts column on every tab
          };

          Arr = {
            style = "row";
            rows = "2";
            columns = "3";
          };

          Streaming = {
            style = "row";
            rows = "2";
            columns = "3";
          };

          dns-vpn = {
            style = "row";
            columns = "2";
          };

          Downloader = {
            style = "row";
            columns = "2";
            rows = "2";
          };

        };
      };

      services = [
        {
          "Downloader " = [
            {
              "qBittorrent" = {
                icon = "qbittorrent.png";
                href = "http://${address}:8080/";
              };
            }
            {
              "Deluge" = {
                icon = "deluge.png";
                href = "http://${address}:8112/";
              };
            }
            {
              "transmission" = {
                icon = "transmission.png";
                href = "http://${address}:9191/";
              };
            }
            {
              "rutorrent/rtorrent" = {
                icon = "rtorrent.png";
                href = "http://${address}:50000/";
              };
            }
            {
              "nzbget" = {
                icon = "qbittorrent.png";
                href = "http://${address}:6789/";
              };
            }
            # {
            #   "Shiori" = {
            #     icon = "shiori.png";
            #     href = "http://${address}:2525/";
            #   };
            # }
            # {
            #   "kavita" = {
            #     icon = "kavita.png";
            #     href = "http://${address}:5000/";
            #   };
            # }
          ];
        }

        {
          "Proxy" = [
            {
              "Caddy" = {
                icon = "caddy.png";
                href = "http://${address}:2019/"; # admin port
              };
            }
            {
              "Traefik" = {
                icon = "traefik.png";
                href = "http://${address}:8082";
              };
            }
            {
              "Nginx" = {
                icon = "nginx.png";
                href = "http://${address}:80/"; # http port
              };
            }
          ];
        }

        {
          "Backup" = [
            {
              "Syncthing" = {
                icon = "syncthing.png";
                href = "http://${address}:8384/";

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
                href = "http://${address}:8000/";
              };
            }
            {
              "Kopia" = {
                icon = "kopia.png";
                href = "http://${address}:8082/";
              };
            }
          ];
        }

        {
          "dns-vpn" = [
            {
              "Adguard" = {
                icon = "adguard-home.png";
                href = "http://${address}:3000/";
              };
            }
            {
              "Wireguard" = {
                icon = "wireguard.png";
                href = "http://${address}:8082/"; # change port later
              };
            }
          ];
        }

        {
          "Streaming" = [
            {
              "Plex" = {
                icon = "plex.png";
                href = "http://${address}:32400/web/";
              };
            }
            {
              "Navidrome" = {
                icon = "navidrome.png";
                href = "http://${address}:4533/";
              };
            }
            {
              "Caddy share" = {
                icon = "caddy.png";
                href = "http://${address}:2016/";
              };
            }
            {
              "Tautulli" = {
                icon = "tautulli.png";
                href = "http://${address}:8181/";
              };
            }
            {
              "Jellyfin" = {
                icon = "jellyfin.png";
                href = "http://${address}:8096/";
              };
            }
            {
              "Jellyseer" = {
                icon = "jellyfin.png";
                href = "http://${address}:5055/";
              };
            }
          ];
        }

        {
          "Monitoring" = [
            {
              "Grafana" = {
                icon = "grafana.png";
                href = "http://${address}:3002/"; # default: 3000
              };
            }
            {
              "Prometheus" = {
                icon = "prometheus.png";
                href = "http://${address}:9090/";
              };
            }
            {
              "Loki" = {
                icon = "loki.png";
                href = "http://${address}:8082/"; # no link yet
                # ping: sonarr.host # for http://sonarr.host/
                # siteMonitor = "http://${address}:3002/"; # verify site exists
              };
            }
          ];
        }

        {
          "Arr" = [
            {
              "Radarr (movies)" = {
                icon = "radarr.png";
                href = "http://${address}:7878/";
              };
            }
            {
              "Bazaar (sub)" = {
                icon = "https://www.bazarr.media/assets/img/logo.png";
                href = "http://${address}:6767/"; # default: 9090
              };
            }
            {
              "Sonarr (tv)" = {
                icon = "sonarr.png";
                href = "http://${address}:8989/";
              };
            }
            {
              "Readarr (books)" = {
                icon = "readarr.png";
                href = "http://${address}:8787/";
              };
            }
            {
              "Lidarr (music)" = {
                icon = "lidarr.png";
                href = "http://${address}:8686/";
              };
            }
            {
              "Prowlarr (indexer)" = {
                icon = "prowlarr.png";
                href = "http://${address}:9696/";
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
                href = "http://${address}:3000/";
              }];
            }
            {
              Django-App = [{
                abbr = "DA";
                href = "http://${address}:8000/";
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

      # http://${address}:8082/
      # listenPort = 8082; # default is 8082

      # Open listen port in the firewall for Homepage
      # note these: 22000 (transfers) and 21027 (discovery)
      openFirewall = true;
    };
  };
}
