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
          Hashicorp = { # group Name in services/bookmarks.yaml
            style = "row";
            columns = "3";
            # initiallyCollapsed = "true";
          };
          Server = {
            style = "column";
            rows = "3";
          };
          Utilities = {
            style = "column";
            rows = "4";
          };
          Monitoring = {
            style = "column";
            rows = "3";
          };
        };
      };

      services = [
        {
          "Hashicorp" = [
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
          "Server" = [
            {
              "Caddy (admin)" = {
                icon = "caddy.png";
                href = "http://localhost:2019/"; # admin port
              };
            }
            {
              "Traefik (placehold)" = {
                icon = "traefik.png";
                href = "http://localhost/";
              };
            }
            {
              "Nginx (placehold)" = {
                icon = "nginx.png";
                href = "http://localhost:80/"; # http port
              };
            }
          ];
        }

        {
          "Monitoring" = [
            {
              "Uptime-Kuma" = {
                icon = "uptime-kuma.png";
                href = "http://localhost:3001/";
              };
            }
            {
              "Cockpit" = {
                icon = "cockpit.png";
                href = "http://localhost:9099/"; # default: 9090
              };
            }
            {
              "Cadvisor" = {
                icon = "cadvisor.png";
                href = "http://localhost:8080/";
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

      # Open ports in the firewall for Homepage
      # 22000 (transfers) and 21027 (discovery)
      # openFirewall = true;
    };
  };
}
