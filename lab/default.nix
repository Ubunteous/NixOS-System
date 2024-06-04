{ lib, ... }:

with lib; {
  options.lab.enable = mkEnableOption "Homelab configuration";
  imports = [
    # ./sysadmin/ssh.nix
    ./sysadmin/k3s.nix
    ./sysadmin/podman.nix
    # ./sysadmin/virtual-box.nix

    # ./monitoring/grafana.nix
    # ./monitoring/prometheus.nix
    # ./monitoring/loki.nix

    # ./server/caddy.nix
    # ./server/nginx.nix
    # ./server/traefik.nix

    # ./multimedia/kodi.nix
    # ./multimedia/jellyfin.nix
    # ./multimedia/sonarr.nix
    # ./multimedia/radarr.nix
    # ./multimedia/readarr.nix
    # ./multimedia/lidarr.nix
    # ./multimedia/bazarr.nix
    # ./multimedia/prowlarr.nix
    # ./multimedia/jackett.nix
    # ./multimedia/plex.nix

    ./homepage.nix
    ./syncthing.nix
    ./self-hosted/shiori.nix
    # ./self-hosted/restic.nix
    # ./self-hosted/adguard.nix
    # ./self-hosted/wireguard.nix

    # ./monitoring/cockpit.nix
    # ./monitoring/cadvisor.nix
    # ./monitoring/uptime-kuma.nix
  ];
}
