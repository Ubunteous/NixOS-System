{ lib, ... }:

with lib; {
  options.lab.enable = mkEnableOption "Homelab configuration";
  imports = [
    ./homepage.nix
    ./cockpit.nix

    ./grafana.nix
    ./prometheus.nix
    ./loki.nix
    ./cadvisor.nix

    # ./server/caddy.nix
    # ./server/nginx.nix
    # ./server/traefik.nix

    # ./self-hosted/jellyfin.nix
    # ./self-hosted/sonarr.nix
    # ./self-hosted/radarr.nix
    # ./self-hosted/readarr.nix
    # ./self-hosted/lidarr.nix
    # ./self-hosted/bazarr.nix
    # ./self-hosted/prowlarr.nix
    # ./self-hosted/jackett.nix

    # ./self-hosted/adguard.nix
    # ./self-hosted/shiori.nix
    # ./self-hosted/syncthing.nix
    # ./self-hosted/uptime-kuma.nix

    ./k3s.nix
    ./podman.nix
    ./virtual-box.nix
  ];
}
