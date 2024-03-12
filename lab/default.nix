{ lib, ... }:

with lib; {
  options.lab.enable = mkEnableOption "Homelab configuration";
  imports = [
    ./homepage.nix
    ./syncthing.nix

    ./k3s.nix
    ./podman.nix
    # ./virtual-box.nix

    # ./monitoring/cockpit.nix
    # ./monitoring/grafana.nix
    # ./monitoring/prometheus.nix
    # ./monitoring/loki.nix
    # ./monitoring/cadvisor.nix
    # ./monitoring/uptime-kuma.nix

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
    # ./self-hosted/plex.nix

    # ./self-hosted/wireguard.nix
    # ./self-hosted/restic.nix
    # ./self-hosted/shiori.nix
    # ./self-hosted/adguard.nix
  ];
}
