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

    ./proxy/caddy.nix
    # ./proxy/nginx.nix
    # ./proxy/traefik.nix

    # ./multimedia/kodi.nix
    # ./multimedia/plex.nix
    # ./multimedia/jellyfin.nix
    # ./multimedia/jellyseer.nix
    # ./multimedia/kavita.nix

    ./multimedia/sonarr.nix
    ./multimedia/radarr.nix
    ./multimedia/readarr.nix
    ./multimedia/lidarr.nix
    ./multimedia/bazarr.nix
    ./multimedia/prowlarr.nix
    ./multimedia/tautulli.nix

    # ./backup/immich.nix
    # ./backup/restic.nix
    ./backup/syncthing.nix

    ./self-hosted/homepage.nix
    ./self-hosted/adguard.nix
    ./self-hosted/wireguard.nix
    # ./self-hosted/navidrome.nix
    # ./self-hosted/unbound.nix
    # ./self-hosted/bind.nix

    # ./self-hosted/authelia.nix
    # ./self-hosted/fail2ban.nix
    # ./self-hosted/shiori.nix
  ];
}
